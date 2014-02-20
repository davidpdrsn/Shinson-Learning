class Belt < ActiveRecord::Base
  has_many :techniques

  validates :color, presence: true
  validates :degree, presence: true,
                     uniqueness: true

  def pretty_format
    "#{color.titleize} (#{degree.downcase})"
  end
end
