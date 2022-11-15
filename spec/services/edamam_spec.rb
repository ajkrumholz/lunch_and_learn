require 'rails_helper'

RSpec.describe EdamamApiService, :vcr do
  before :each do 
    Rails.cache.clear
  end
  
  
  describe 'it searches the edamam api service for recipes from a country' do
    describe '::search(country)' do
      it 'returns a response containing recipe info' do
        country = 'vietnam'
        result = described_class.search(country)

        expect(result).to be_a Hash
        expect(result).to have_key(:q)
        expect(result[:q]).to eq(country)
        expect(result).to have_key(:from)
        expect(result[:from]).to be_an Integer
        expect(result).to have_key(:to)
        expect(result[:to]).to be_an Integer
        expect(result).to have_key(:more)
        expect(result[:more]).to be_in [true, false]
        expect(result).to have_key(:count)
        expect(result[:count]).to be_an Integer
        expect(result).to have_key(:hits)
        
        hits = result[:hits]
        expect(hits).to be_an Array
        expect(hits.size).to eq(10)

        recipe_info = hits.first
        expect(recipe_info).to be_a Hash
        expect(recipe_info).to have_key(:recipe)

        recipe = recipe_info[:recipe]
        expect(recipe).to be_a Hash
        expect(recipe).to have_key(:uri)
        expect(recipe[:uri]).to be_a String
        expect(recipe).to have_key(:label)
        expect(recipe[:label]).to be_a String
        expect(recipe).to have_key(:image)
        expect(recipe[:image]).to be_a String
        expect(recipe).to have_key(:source)
        expect(recipe[:source]).to be_a String
        expect(recipe).to have_key(:url)
        expect(recipe[:url]).to be_a String
        expect(recipe).to have_key(:yield)
        expect(recipe[:yield]).to be_a Float
        expect(recipe).to have_key(:ingredientLines)
        expect(recipe[:ingredientLines]).to be_an Array
        expect(recipe).to have_key(:ingredients)
        expect(recipe[:ingredients]).to be_an Array
      end

      describe 'if no info is found' do
        it 'returns an empty response' do
          country = '||||'
          result = described_class.search(country)

          expect(result).to be_a Hash
          expect(result).to have_key(:q)
          expect(result[:q]).to eq(country)
          expect(result).to have_key(:from)
          expect(result[:from]).to be_an Integer
          expect(result).to have_key(:to)
          expect(result[:to]).to be_an Integer
          expect(result).to have_key(:more)
          expect(result[:more]).to be_in [true, false]
          expect(result).to have_key(:count)
          expect(result[:count]).to be_an Integer
          expect(result).to have_key(:hits)
          
          hits = result[:hits]
          expect(hits).to be_an Array
          expect(hits).to be_empty
        end
      end
    end
  end
end