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
end
