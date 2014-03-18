# == Schema Information
#
# Table name: scores
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  study_id        :integer
#  correct_answers :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'math_helper'

class Score < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :study, touch: true

  def to_percent
    MathHelper.percentage_difference correct_answers, study.techniques.count
  end
end
