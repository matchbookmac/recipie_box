require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require 'pg'
require 'pry'
require './lib/category'
require './lib/ingredient'
require './lib/recipie'

before do
  @all_recipies = Recipie.all
  @all_ingredients = Ingredient.all
end

get '/' do
  erb :index
end

get '/recipies' do
  erb :recipies
end

get '/recipies/new' do
  erb :recipie_form
end

post '/recipies/new' do
  Recipie.create(name: params['recipie_name'], instructions: params['instructions'])
  redirect to '/recipies'
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
