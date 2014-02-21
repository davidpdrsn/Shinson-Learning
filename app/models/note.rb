class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :technique

  validates :text, presence: true
  validates :user_id, presence: true
  validates :technique_id, presence: true
end
