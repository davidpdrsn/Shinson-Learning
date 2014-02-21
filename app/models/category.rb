class Category < ActiveRecord::Base
  has_many :techniques

  validates :name, presence: true,
                   uniqueness: true

  def html_class
    name.downcase.gsub(" ", "-")
  end
end
