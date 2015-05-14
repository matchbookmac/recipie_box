class AddQuantityAndQuantitytypeTablesToJoinTable < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :quantity, :float
    add_column :ingredients_recipes, :quantity_type, :string
  end
end
