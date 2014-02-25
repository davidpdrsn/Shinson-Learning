class AddIndexToTechniques < ActiveRecord::Migration
  def change
    add_index :techniques, :user_id
  end
end
