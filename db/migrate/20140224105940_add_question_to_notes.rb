class AddQuestionToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :question, :boolean, default: false
  end
end
