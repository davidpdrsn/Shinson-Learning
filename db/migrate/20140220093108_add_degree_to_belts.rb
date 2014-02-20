class AddDegreeToBelts < ActiveRecord::Migration
  def change
    add_column :belts, :degree, :string
  end
end
