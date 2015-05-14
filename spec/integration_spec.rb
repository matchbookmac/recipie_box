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
    choose 'rating5'
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
    click_on 'Edit'
    check(category.id)
    click_button 'add_categories'
    expect(page).to have_content('Breakfast')
  end
end

describe 'Adding an ingredient to a recipe path', :type => :feature do
  it 'Starts on the ingredients page. Lets a user click on an ingredient to see details for that ingredient. Lets a user add a ingredient to that recipe' do
    recipe = Recipe.create(name: 'Eggs Benedict', instructions: 'Go to a diner, do not try at home', rating: 5)
    ingredient = Ingredient.create(name: 'Egg Whites')
    visit '/recipes'
    click_on 'Eggs Benedict'
    click_on 'Edit'
    check(ingredient.id)
    click_button 'add_ingredients'
    expect(page).to have_content('Egg Whites')
  end
end

describe 'Viewing the list of ingredients', :type => :feature do
  it 'Shows the list of ingredients' do
    ingredient = Ingredient.create(name: 'Spam')
    visit '/ingredients'
    expect(page).to have_content(ingredient.name)
    click_on ingredient.name
    expect(page).to have_content("#{ingredient.name}")
  end
end

describe 'Updating and Deleting an ingredient from the list of ingredients', :type => :feature do
  it 'deletes an ingredient' do
    ingredient_0 = Ingredient.create(name: 'Spam')
    ingredient_1 = Ingredient.create(name: 'Lard')
    visit "/ingredients/#{ingredient_1.id}"
    expect(page).to have_content(ingredient_1.name)
    click_button 'delete_ingredient'
    expect(page).to_not have_content("#{ingredient_1.name}")
    expect(page).to have_content(ingredient_0.name)
  end
  it 'updates the ingredient name' do
    ingredient = Ingredient.create(name: 'Milk')
    visit "/ingredients/#{ingredient.id}"
    fill_in 'new_ingredient_name', with: 'Butter'
    click_button 'update_ingredient'
    expect(page).to have_content 'Butter'
  end
end

describe 'Updating and Deleting a recipe from the list of recipes', :type => :feature do
  it 'deletes a recipe' do
    recipe_0 = Recipe.create(name: 'Fried Eggs')
    recipe_1 = Recipe.create(name: 'Toast')
    visit "/recipes/#{recipe_1.id}"
    expect(page).to have_content(recipe_1.name)
    click_on 'Edit'
    click_button 'delete_recipe'
    expect(page).to_not have_content("#{recipe_1.name}")
    expect(page).to have_content(recipe_0.name)
  end
  it 'updates the recipe name' do
    recipe = Recipe.create(name: 'Beer')
    visit "/recipes/#{recipe.id}"
    click_on 'Edit'
    fill_in 'new_recipe_name', with: 'Light Beer'
    click_button 'update_recipe'
    expect(page).to have_content 'Light Beer'
  end
  it 'updates the recipe instructions' do
    recipe = Recipe.create(name: 'Beer', instructions: 'Water, barley, boil. Add hops, cool. Add yeast. Wait. Have fun. Be Safe')
    visit "/recipes/#{recipe.id}"
    click_on 'Edit'
    fill_in 'new_recipe_instructions', with: 'Go to bar.'
    click_button 'update_instructions'
    expect(page).to have_content 'Go to bar.'
  end
  it 'updates the recipe rating' do
    recipe = Recipe.create(name: 'Beer', rating: 3)
    visit "/recipes/#{recipe.id}"
    click_on 'Edit'
    choose 'rating5'
    click_button 'update_rating'
    expect(page).to have_content 'Rating: 5'
  end
end

describe 'Updating and Deleting a category from the list of categories', :type => :feature do
  it 'deletes a category' do
    category_0 = Category.create(name: 'Brunch')
    category_1 = Category.create(name: 'Amazing')
    visit "/categories/#{category_1.id}"
    expect(page).to have_content(category_1.name)
    click_button 'delete_category'
    expect(page).to_not have_content("#{category_1.name}")
    expect(page).to have_content(category_0.name)
  end
  it 'updates the category name' do
    category = Category.create(name: 'Sweets')
    visit "/categories/#{category.id}"
    fill_in 'new_category_name', with: 'Boring'
    click_button 'update_category'
    expect(page).to have_content 'Boring'
  end
end

describe 'The recipe details path', :type => :feature do
  it 'Also shows a recipes rating and instructions' do
    recipe = Recipe.create(name: 'Pie', instructions: 'Get pie shell. Get filling. Put filling in pie shell. Eat pie. Be happy.', rating: 5)
    visit "/recipes/#{recipe.id}"
    expect(page).to have_content 'Rating: 5'
    expect(page).to have_content 'Be happy.'
  end
end
