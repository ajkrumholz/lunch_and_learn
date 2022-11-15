require 'rails_helper'

RSpec.describe RecipesFacade, :vcr do
  describe '::search_recipes(country)' do
    it 'returns a collection of Recipe objects' do
      country = 'denmark'
      result = described_class.search_recipes(country)
      expect(result).to be_an Array
      expect(result.size).to eq(10)

      recipe = result.first
      expect(recipe).to be_a Recipe
      expect(recipe.country).to eq(country)
      expect(recipe.id).to eq("null")
      expect(recipe.image).to be_a String
      expect(recipe.url).to be_a String
      expect(recipe.title).to be_a String
    end
  end
end