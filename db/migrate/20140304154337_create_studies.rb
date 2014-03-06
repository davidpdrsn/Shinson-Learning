class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.references :belt
      t.references :category
      t.references :user
    end

    add_index :studies, :belt_id
    add_index :studies, :category_id
    add_index :studies, :user_id
  end
end
