require 'belt_extensions'

class Belt < ActiveRecord::Base
  has_many :techniques

  validates :color, presence: true
  validates :degree, presence: true,
                     uniqueness: true

  include BeltExtensions::PrettyPrinter
end
