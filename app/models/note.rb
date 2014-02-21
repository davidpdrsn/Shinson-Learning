class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :technique

  validates :text, presence: true
end
