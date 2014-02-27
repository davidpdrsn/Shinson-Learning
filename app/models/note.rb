class Note < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :technique, counter_cache: true

  validates :text, presence: true
  validates :user_id, presence: true
  validates :technique_id, presence: true
end
