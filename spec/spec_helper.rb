ENV['RACK_ENV'] = 'test'

require 'sinatra/activerecord'
require 'rspec'
require 'category'
require 'recipe'
require 'ingredient'
require 'pry'
require 'pg'

RSpec.configure do |config|
  config.before(:each) do
    Category.all.each do |category|
      category.destroy
    end
    Recipe.all.each do |recipe|
      recipe.destroy
    end
    Ingredient.all.each do |ingredient|
      ingredient.destroy
    end
  end
  config.after(:each) do
    Category.all.each do |category|
      category.destroy
    end
    Recipe.all.each do |recipe|
      recipe.destroy
    end
    Ingredient.all.each do |ingredient|
      ingredient.destroy
    end
  end
end
