class Technique < ActiveRecord::Base
  belongs_to :belt
  belongs_to :category

  validates :name, presence: true,
                   uniqueness: true
end
