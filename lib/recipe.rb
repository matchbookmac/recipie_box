class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :ingredients

  def self.sort_by_rating
    rated_recipe_ids = []
    Recipe.all.each do |recipe|
      rated_recipe_ids << [recipe['rating'], recipe['id']]
    end
    rated_recipe_ids = rated_recipe_ids.sort.reverse
    recipes = []
    rated_recipe_ids.each do |id|
      recipes << Recipe.find(id[1])
    end
    recipes
  end
end
