class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :user
      t.references :study
      t.integer :correct_answers
    end

    add_index :scores, :user_id
    add_index :scores, :study_id
  end
end
