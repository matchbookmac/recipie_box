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
