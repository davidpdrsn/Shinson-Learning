class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :study

  def to_percent
    return 0 if study.techniques.length == 0
    correct_answers.to_f / study.techniques.length * 100
  end
end
