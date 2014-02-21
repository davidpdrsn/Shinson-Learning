class Belt < ActiveRecord::Base
  has_many :techniques

  validates :color, presence: true
  validates :degree, presence: true,
                     uniqueness: true

  def pretty_print
    "#{color.titleize} (#{degree.downcase})"
  end
end
