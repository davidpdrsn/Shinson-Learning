class ChangeNotesName < ActiveRecord::Migration
  def change
    rename_column :notes, :name, :text
  end
end
