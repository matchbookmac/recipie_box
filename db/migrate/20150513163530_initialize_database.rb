class InitializeDatabase < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.column :name, :string
      t.column :instructions, :text
      t.column :rating, :int
    end
    create_table :ingredients do |t|
      t.column :name, :string
    end
    create_table :categories do |t|
      t.column :name, :string
    end

    create_table :categories_recipes, id: false do |t|
      t.integer :category_id
      t.integer :recipe_id
    end

    add_index :categories_recipes, :category_id
    add_index :categories_recipes, :recipe_id

    create_table :ingredients_recipes, id: false do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
    end

    add_index :ingredients_recipes, :ingredient_id
    add_index :ingredients_recipes, :recipe_id
  end
end
