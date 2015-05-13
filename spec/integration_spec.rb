require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe 'Adding a recipie path', :type => :feature do
  it 'Shows a welcome page. On clicking add recipie link, shows a page with forms for creating a new recipie. On submit, shows the list of recipies.' do
    visit '/'
    click_on 'add_recipie'
    fill_in 'recipie_name', with: 'Pulled Pork'
    fill_in 'instructions', with: 'Roast pork in 200 degree oven for 10 hours. Eat pork.'
    select '5', from: 'rating'
    click_button 'recipie_save'
    expect(page).to have_content('Pulled Pork')
  end
end
