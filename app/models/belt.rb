class Belt < ActiveRecord::Base
  validates :color, presence: true
  validates :degree, presence: true
end
