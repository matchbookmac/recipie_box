require 'spec_helper'

describe Ingredient do
  it 'ensures the ingredient is not a duplicate' do
    Ingredient.create(name: 'Egg')
    ingredient = Ingredient.new(name: 'Egg')
    expect(ingredient.save).to eq(false)
  end
end
