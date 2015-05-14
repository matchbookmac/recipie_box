require 'spec_helper'

describe Category do
  it 'ensures the category is not a duplicate' do
    Category.create(name: 'Breakfast')
    category = Category.new(name: 'Breakfast')
    expect(category.save).to eq(false)
  end
end
