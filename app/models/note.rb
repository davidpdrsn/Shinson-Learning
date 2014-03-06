# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  text         :text
#  user_id      :integer
#  technique_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  question     :boolean          default(FALSE)
#

class Note < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :technique, counter_cache: true

  validates :text, presence: true
  validates :user_id, presence: true
  validates :technique_id, presence: true
end
