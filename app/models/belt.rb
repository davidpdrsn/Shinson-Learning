# == Schema Information
#
# Table name: belts
#
#  id     :integer          not null, primary key
#  color  :string(255)
#  degree :string(255)
#

class Belt < ActiveRecord::Base
  has_many :techniques

  validates :color, presence: true
  validates :degree, presence: true,
                     uniqueness: true

  def pretty_print
    "#{color.titleize} (#{degree.downcase})"
  end
end
