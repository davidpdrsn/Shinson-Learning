# == Schema Information
#
# Table name: techniques
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  belt_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#  user_id     :integer
#  notes_count :integer          default(0), not null
#

require 'grouper'

class Technique < ActiveRecord::Base
  include Comparable

  belongs_to :belt
  belongs_to :category
  belongs_to :user, touch: true
  has_many :notes, dependent: :destroy
  has_and_belongs_to_many :studies

  validates :name, presence: true
  validates :belt_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true

  delegate :name, to: :category, prefix: :category
  delegate :pretty_print, to: :belt, prefix: :belt

  def self.unstudied_for_user user
    user.techniques.select { |t| t.studies.blank? }
  end

  def self.as_hash_for_user user
    user.techniques.inject([]) do |acc, technique|
      attributes = technique.attributes.tap do |attrs|
        attrs["notes"] = technique.notes
        attrs["belt"] = technique.belt
        attrs["category"] = technique.category
      end

      acc << attributes
    end
  end

  def self.for_user_grouped_by user, *groupings
    Grouper.new(user.sorted_techniques).group_by(*groupings)
  end

  def <=> another
    name_to_a(self) <=> name_to_a(another)
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  private

  def name_to_a technique
    match = technique.name.match /(?<string>.*?)(?<digit>\d+)$/

    if match
      [match[:string], match[:digit].to_i]
    else
      [technique.name]
    end
  end
end
