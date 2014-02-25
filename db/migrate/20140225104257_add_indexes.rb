class AddIndexes < ActiveRecord::Migration
  def change
    add_index :notes, :user_id
    add_index :notes, :technique_id
    add_index :techniques, :belt_id
    add_index :techniques, :category_id
  end
end
