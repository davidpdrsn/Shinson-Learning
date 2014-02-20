class Technique < ActiveRecord::Base
  belongs_to :belt
  belongs_to :category
  belongs_to :user

  validates :name, presence: true,
                   uniqueness: true
end
