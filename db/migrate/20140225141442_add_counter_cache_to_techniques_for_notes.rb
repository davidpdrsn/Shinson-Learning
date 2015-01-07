class AddCounterCacheToTechniquesForNotes < ActiveRecord::Migration
  def up
    add_column :techniques, :notes_count, :integer, default: 0, null: false
  end

  def down
    remove_column :techniques, :notes_count
  end
end
