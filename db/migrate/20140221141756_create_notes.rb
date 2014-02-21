class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :name
      t.references :user
      t.references :technique

      t.timestamps
    end
  end
end
