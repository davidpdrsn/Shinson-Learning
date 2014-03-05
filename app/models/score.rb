require 'math_helper'

class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :study, touch: true

  def to_percent
    MathHelper.percentage_difference correct_answers, study.techniques.count
  end
end
