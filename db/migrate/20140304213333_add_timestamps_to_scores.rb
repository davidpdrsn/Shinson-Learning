class AddTimestampsToScores < ActiveRecord::Migration
  def change
    add_column :scores, :created_at, :datetime
    add_column :scores, :updated_at, :datetime
  end
end
