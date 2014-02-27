require 'grouper'

class Technique < ActiveRecord::Base
  belongs_to :belt
  belongs_to :category
  belongs_to :user, touch: true
  has_many :notes

  validates :name, presence: true
  validates :belt_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true

  def self.for_user_grouped_by(user, *groupings)
    techniques = user.techniques.includes(:category, :belt).sort
    Grouper.new(techniques).group_by(*groupings)
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

  def <=>(another)
    name_to_a(self) <=> name_to_a(another)
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  private

  def name_to_a(technique)
    match = technique.name.match(/(?<string>.*?)(?<digit>\d+)$/)

    if match
      [match[:string], match[:digit].to_i]
    else
      [technique.name]
    end
  end
end
