require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require 'pg'
require 'pry'
require './lib/category'
require './lib/ingredient'
require './lib/recipe'

before do
  @all_recipes = Recipe.all
  @all_ingredients = Ingredient.all
  @all_categories = Category.all
end

get '/test' do
  erb :test
end

get '/reset' do
  Category.all.each do |category|
    category.destroy
  end
  Recipe.all.each do |recipe|
    recipe.destroy
  end
  Ingredient.all.each do |ingredient|
    ingredient.destroy
  end
  redirect to '/'
end

get '/' do
  erb :index
end

get '/recipes' do
  erb :recipes
end

get '/recipes/sort/rating' do
  @all_recipes = Recipe.sort_by_rating
  erb :recipes
end

get '/recipes/new' do
  erb :recipe_form
end

post '/recipes/new' do
  recipe = Recipe.new(name: params['recipe_name'], instructions: params['instructions'], rating: params['rating'])
  if recipe.save
    redirect to '/recipes'
  else
    @object_with_errors = recipe
    @path = '/recipes/new'
    erb :errors
  end
end

get '/recipes/:id' do
  @recipe = Recipe.find(params['id'])
  @categories = @recipe.categories
  @ingredients = @recipe.ingredients
  erb :recipe
end

get '/recipes/:id/edit' do
  @recipe = Recipe.find(params['id'])
  @categories = @recipe.categories
  @ingredients = @recipe.ingredients
  erb :recipe_edit
end

delete '/recipes/:id/delete' do
  Recipe.find(params['id']).destroy
  redirect to '/recipes'
end

patch '/recipes/:id/update/name' do
  @recipe = Recipe.find(params['id'])
  @recipe.update(name: params['new_recipe_name'])
  redirect to "/recipes/#{@recipe.id}"
end

patch '/recipes/:id/update/instructions' do
  @recipe = Recipe.find(params['id'])
  @recipe.update(instructions: params['new_recipe_instructions'])
  redirect to "/recipes/#{@recipe.id}"
end

patch '/recipes/:id/update/rating' do
  @recipe = Recipe.find(params['id'])
  @recipe.update(rating: params['rating'])
  redirect to "/recipes/#{@recipe.id}"
end

patch '/recipes/:id/add/category' do
  @recipe = Recipe.find(params['id'])
  added_categories = Category.find(params['category_id'])
  added_categories.each do |category|
    @recipe.categories.push(category)
  end
  @categories = @recipe.categories
  @ingredients = @recipe.ingredients
  redirect to "/recipes/#{params['id']}"
end

patch '/recipes/:id/add/ingredient' do
  @recipe = Recipe.find(params['id'])
  added_ingredients = Ingredient.find(params['ingredient_id'])
  added_ingredients.each do |ingredient|
    @recipe.ingredients.push(ingredient)
  end

  @categories = @recipe.categories
  @ingredients = @recipe.ingredients
  redirect to "/recipes/#{params['id']}"
end

get '/ingredients' do
  erb :ingredients
end

get '/ingredients/new' do
  erb :ingredient_form
end

post '/ingredients/new' do
  ingredient = Ingredient.new(name: params['ingredient_name'])
  if ingredient.save
    redirect to '/ingredients'
  else
    @object_with_errors = ingredient
    @path = '/ingredients/new'
    erb :errors
  end
end

get '/ingredients/:id' do
  @ingredient = Ingredient.find(params['id'])
  @recipes = @ingredient.recipes
  erb :ingredient
end

delete '/ingredients/:id/delete' do
  Ingredient.find(params['id']).destroy
  redirect to '/ingredients'
end

patch '/ingredients/:id/update' do
  @ingredient = Ingredient.find(params['id'])
  @ingredient.update(name: params['new_ingredient_name'])
  redirect to "/ingredients/#{@ingredient.id}"
end

get '/categories' do
  erb :categories
end

get '/categories/new' do
  erb :category_form
end

post '/categories/new' do
  category = Category.new(name: params['category_name'])
  if category.save
    redirect to '/categories'
  else
    @object_with_errors = category
    @path = '/categories/new'
    erb :errors
  end
end

get '/categories/:id' do
  @category = Category.find(params['id'])
  @recipes = @category.recipes
  erb :category
end

delete '/categories/:id/delete' do
  Category.find(params['id']).destroy
  redirect to '/categories'
end

patch '/categories/:id/update' do
  @category = Category.find(params['id'])
  @category.update(name: params['new_category_name'])
  redirect to "/categories/#{@category.id}"
end

patch '/categories/:id/add/recipe' do
  @category = Category.find(params['id'])
  added_recipes = Recipe.find(params['recipe_id'])
  added_recipes.each do |recipe|
    @category.recipes.push(recipe)
  end
  @recipes = @category.recipes
  redirect to "/categories/#{params['id']}"
end
