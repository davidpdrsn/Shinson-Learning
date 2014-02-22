require 'grouper'

class Technique < ActiveRecord::Base
  belongs_to :belt
  belongs_to :category
  belongs_to :user
  has_many :notes

  validates :name, presence: true,
                   uniqueness: true
  validates :belt_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true

  def self.for_user_grouped_by(user, *groupings)
    Grouper.new(user.techniques.sort_by(&:name)).group_by(*groupings)
  end

  def category_html_class
    category.html_class
  end

  def belt_pretty_print
    belt.pretty_print
  end

  def category_name
    category.name
  end

  def note_count
    notes.count
  end
end
