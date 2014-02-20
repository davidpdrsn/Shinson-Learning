class Belt < ActiveRecord::Base
  has_many :techniques

  validates :color, presence: true
  validates :degree, presence: true
end
