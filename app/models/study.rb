require 'math_helper'

class Study < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :belt
  belongs_to :category
  has_many :scores, dependent: :destroy

  validate :has_techniques

  def techniques
    Technique.where user: user, belt: belt, category: category
  end

  def pretty_print
    "#{belt.pretty_print} #{category.name}"
  end

  def to_json
    {
      study: self,
      techniques: techniques
    }.to_json
  end

  def average_score
    MathHelper.average(scores.map(&:to_percent)).round(2)
  end

  def cached_average_score
    Rails.cache.fetch([self, "score"]) { average_score }
  end

  def cached_scores_count
    Rails.cache.fetch([self, "score_count"]) { scores.count }
  end

  def newest_score
    scores.order("created_at").last
  end

  private

  def has_techniques
    unless techniques.present?
      errors[:base] << "No techniques for #{pretty_print}"
    end
  end
end
