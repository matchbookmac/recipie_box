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
  @recipies = Recipie.all
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
  recipie_name = params['recipie_name']
  instructions = params['instructions']
  Recipie.create(name: recipie_name, instructions: instructions)
  redirect to :recipies
end
