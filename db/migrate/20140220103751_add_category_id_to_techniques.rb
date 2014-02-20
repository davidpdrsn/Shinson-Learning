class AddCategoryIdToTechniques < ActiveRecord::Migration
  def change
    add_column :techniques, :category_id, :integer
  end
end
