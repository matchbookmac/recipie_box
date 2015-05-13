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
