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

get '/' do
  erb :index
end

get '/recipes' do
  erb :recipes
end

get '/recipes/new' do
  erb :recipe_form
end

post '/recipes/new' do
  Recipe.create(name: params['recipe_name'], instructions: params['instructions'])
  redirect to '/recipes'
end

get '/ingredients' do
  erb :ingredients
end

get '/ingredients/new' do
  erb :ingredient_form
end

post '/ingredients/new' do
  Ingredient.create(name: params['ingredient_name'])
  redirect to '/ingredients'
end

get '/categories' do
  erb :categories
end

get '/categories/new' do
  erb :category_form
end

post '/categories/new' do
  Category.create(name: params['category_name'])
  redirect to '/categories'
end

get '/categories/:id' do
  @category = Category.find(params['id'])
  @recipes = @category.recipes
  erb :category
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
