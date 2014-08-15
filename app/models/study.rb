# == Schema Information
#
# Table name: studies
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

require 'math_helper'

class Study < ActiveRecord::Base
  belongs_to :user, touch: true
  has_and_belongs_to_many :techniques
  has_many :scores, dependent: :destroy

  validates :name, presence: true
  validate :has_techniques
  validate :techniques_belong_to_user
  validate :name_not_duplicated

  def self.sorted_by_name
    order 'name'
  end

  def self.neglected
    select &:neglected?
  end

  def to_json
    {
      study: self,
      techniques: techniques.shuffle
    }.to_json
  end

  def average_score
    MathHelper.average(scores.all.map(&:to_percent)).round(2)
  end

  def cached_scores_count
    Rails.cache.fetch([self, "score_count"]) { scores.count }
  end

  def newest_score
    scores.order("created_at").last
  end

  def neglected?
    never_studied? || !studied_recently?
  end

  private

  def studied_recently?
    newest_score.created_at > 2.weeks.ago
  end

  def never_studied?
    scores.count == 0
  end

  def name_not_duplicated
    if user.present? && user.studies.reject(&:new_record?).any? { |study| study.name == self.name }
      errors[:base] << "You already have a study with that name"
    end
  end

  def techniques_belong_to_user
    unless techniques.all? { |t| t.user == user }
      errors[:base] << "You can only study your own techniques"
    end
  end

  def has_techniques
    if techniques.blank?
      errors[:base] << "A study most have techniques"
    end
  end
end
