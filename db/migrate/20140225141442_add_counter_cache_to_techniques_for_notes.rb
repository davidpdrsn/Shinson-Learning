class AddCounterCacheToTechniquesForNotes < ActiveRecord::Migration
  def up
    add_column :techniques, :notes_count, :integer, default: 0, null: false

    Technique.find_each(select: 'id') do |result|
      Technique.reset_counters(result.id, :notes)
    end
  end

  def down
    remove_column :techniques, :notes_count
  end
end
