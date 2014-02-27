require 'grouper'
require 'grouper_techniques'
require 'parameterizer'
require 'technique_extensions'

class Technique < ActiveRecord::Base
  belongs_to :belt
  belongs_to :category
  belongs_to :user, touch: true
  has_many :notes, dependent: :destroy

  validates :name, presence: true
  validates :belt_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true

  include TechniqueExtensions::Delegators
  include TechniqueExtensions::Comparisons
  include Parameterizer
  extend Grouper::Techniques
end
