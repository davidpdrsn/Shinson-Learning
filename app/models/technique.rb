# == Schema Information
#
# Table name: techniques
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  belt_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#  user_id     :integer
#  notes_count :integer          default(0), not null
#

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
