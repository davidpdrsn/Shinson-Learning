class Study < ActiveRecord::Base
  belongs_to :user
  belongs_to :belt
  belongs_to :category

  def techniques
    Technique.where user: user, belt: belt, category: category
  end

  def pretty_print
    "#{belt.pretty_print} #{category.name}"
  end
end
