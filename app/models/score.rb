require 'calculates_percentages'

class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :study

  def to_percent
    CalculatesPercentages.of correct_answers, study.techniques.count
  end
end
