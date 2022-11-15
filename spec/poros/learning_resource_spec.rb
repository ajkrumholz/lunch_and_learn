require 'rails_helper'

RSpec.describe Recipe, :vcr do
  let!(:data) {
    {
      recipe: {
        label: "string",
        url: 'www.string.com',
        image: 'www.string.com'
      }
    }
  }
  let!(:country) { "country" }
  let!(:recipe) { Recipe.new(data, country) }

  it 'has attributes' do
    expect(recipe).to be_a Recipe
    expect(recipe.id).to eq("null")
    expect(recipe.title).to be_a String
    expect(recipe.url).to be_a String
    expect(recipe.url).to be_a String
    expect(recipe.country).to eq(country)
  end
end