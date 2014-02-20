class Category < ActiveRecord::Base
  has_many :techniques

  validates :name, presence: true,
                   uniqueness: true
end
