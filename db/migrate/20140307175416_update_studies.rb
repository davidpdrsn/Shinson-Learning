class UpdateStudies < ActiveRecord::Migration
  def up
    add_column :studies, :name, :string
    remove_column :studies, :category_id
    remove_column :studies, :belt_id

    create_table :studies_techniques, id: false do |t|
      t.references :study
      t.references :technique
    end

    add_index :studies_techniques, :study_id
    add_index :studies_techniques, :technique_id
  end

  def down
    remove_column :studies, :name
    add_column :studies, :category_id, :integer
    add_column :studies, :belt_id, :integer

    drop_table :studies_techniques
  end
end
