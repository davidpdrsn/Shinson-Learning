class Technique < ActiveRecord::Base
  belongs_to :belt
  belongs_to :category
  belongs_to :user

  validates :name, presence: true,
                   uniqueness: true
  validates :belt_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true

  def category_html_class
    category.html_class
  end

  def belt_pretty_print
    belt.pretty_print
  end

  def category_name
    category.name
  end
end
