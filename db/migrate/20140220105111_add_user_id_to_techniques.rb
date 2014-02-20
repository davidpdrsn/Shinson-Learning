class AddUserIdToTechniques < ActiveRecord::Migration
  def change
    add_column :techniques, :user_id, :integer
  end
end
