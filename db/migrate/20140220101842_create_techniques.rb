class CreateTechniques < ActiveRecord::Migration
  def change
    create_table :techniques do |t|
      t.string :name
      t.text :description
      t.references :belt
      t.timestamps
    end
  end
end
