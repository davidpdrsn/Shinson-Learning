class Technique < ActiveRecord::Base
  validates :name, presence: true
end
