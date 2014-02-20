class Technique < ActiveRecord::Base
  belongs_to :belt

  validates :name, presence: true,
                   uniqueness: true
end
