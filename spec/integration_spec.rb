require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe 'Adding a recipe path', :type => :feature do
  it 'Shows a welcome page. On clicking add recipe link, shows a page with forms for creating a new recipe. On submit, shows the list of recipes.' do
    visit '/'
    click_on 'add_recipe'
    fill_in 'recipe_name', with: 'Pulled Pork'
    fill_in 'instructions', with: 'Roast pork in 200 degree oven for 10 hours. Eat pork.'
    select '5', from: 'rating'
    click_button 'recipe_save'
    expect(page).to have_content('Pulled Pork')
  end
end

describe 'Adding a ingredient path', :type => :feature do
  it 'Shows a welcome page. On clicking add ingredient link, shows a page with forms for creating a new ingredient. On submit, shows the list of ingredients.' do
    visit '/'
    click_on 'add_ingredient'
    fill_in 'ingredient_name', with: 'BBQ Sauce'
    click_button 'ingredient_save'
    expect(page).to have_content('BBQ Sauce')
  end
end

describe 'Adding a category path', :type => :feature do
  it 'Shows a welcome page. On clicking add category link, shows a page with forms for creating a new category. On submit, shows the list of ingredients.' do
    visit '/'
    click_on 'add_category'
    fill_in 'category_name', with: 'Breakfast'
    click_button 'category_save'
    expect(page).to have_content('Breakfast')
  end
end

describe 'Adding a recipe to a category path', :type => :feature do
  it 'Starts on the categories page. Lets a user click on a category to see details for that category. Lets a user add a recipe to that category' do
    recipe = Recipe.create(name: 'Eggs Benedict', instructions: 'Go to a diner, do not try at home', rating: 5)
    category = Category.create(name: 'Breakfast')
    visit '/categories'
    click_on 'Breakfast'
    check(recipe.id)
    click_button 'add_recipes'
    expect(page).to have_content('Eggs Benedict')
  end
end

describe 'Adding a category to a recipe path', :type => :feature do
  it 'Starts on the recipes page. Lets a user click on a recipe to see details for that recipe. Lets a user add a category to that recipe' do
    recipe = Recipe.create(name: 'Eggs Benedict', instructions: 'Go to a diner, do not try at home', rating: 5)
    category = Category.create(name: 'Breakfast')
    visit '/recipes'
    click_on 'Eggs Benedict'
    check(category.id)
    click_button 'add_categories'
    expect(page).to have_content('Breakfast')
  end
end
