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

require 'spec_helper'

describe Note do
  it { should belong_to :user }
  it { should belong_to :technique }

  it { should validate_presence_of :text }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :technique_id }
end
