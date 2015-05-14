require 'spec_helper'

describe Recipe do
  describe '.sort_by_rating' do
    it 'will sort all recipies by their rating' do
      recipe_0 = Recipe.create({name: 'Pie', instructions: 'make it', rating: 3})
      recipe_1 = Recipe.create({name: 'Cake', instructions: 'bake it', rating: 2})
      recipe_2 = Recipe.create({name: 'Salt', instructions: 'shake it', rating: 5})
      recipe_3 = Recipe.create({name: 'Shake', instructions: 'take it', rating: 2})
      recipe_4 = Recipe.create({name: 'Sauce', instructions: 'plate it', rating: 3})
      expect(Recipe.sort_by_rating).to eq([recipe_2, recipe_4, recipe_0, recipe_3, recipe_1])
    end
  end

  it 'ensures the recipe is not a duplicate' do
    Recipe.create(name: 'Toast')
    recipe = Recipe.new(name: 'Toast')
    expect(recipe.save).to eq(false)
  end
end
