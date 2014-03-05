require 'math_helper'

class Study < ActiveRecord::Base
  belongs_to :user
  belongs_to :belt
  belongs_to :category
  has_many :scores, dependent: :destroy

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
    MathHelper.average scores.map(&:to_percent)
  end

  def newest_score
    scores.order("created_at").last
  end

  private

  def sum_of_scores
    scores.map(&:to_percent).inject 0, :+
  end
end
