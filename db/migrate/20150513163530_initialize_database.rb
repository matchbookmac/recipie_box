class InitializeDatabase < ActiveRecord::Migration
  def change
    create_table :recipies do |t|
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

    create_table :categories_recipies, id: false do |t|
      t.integer :category_id
      t.integer :recipie_id
    end

    add_index :categories_recipies, :category_id
    add_index :categories_recipies, :recipie_id

    create_table :ingredients_recipies, id: false do |t|
      t.integer :ingredient_id
      t.integer :recipie_id
    end

    add_index :ingredients_recipies, :ingredient_id
    add_index :ingredients_recipies, :recipie_id
  end
end
