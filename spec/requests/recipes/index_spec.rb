require 'rails_helper'

RSpec.describe 'recipes#index', :vcr do
  describe 'happy path' do
    describe 'when a request is made to api/v1/recipes?country={country}' do
      it 'returns a json response' do
        country = "thailand"
        get "/api/v1/recipes?country=#{country}"
        
        happy_path(response)
      end

      it 'works with different cases' do
        country = "Thailand"
        get "/api/v1/recipes?country=#{country}"

        result = json(response)
        expect(result[:data]).not_to be_empty
        happy_path(response)

        country = "THAILAND"
        get "/api/v1/recipes?country=#{country}"

        result = json(response)
        expect(result[:data]).not_to be_empty
        happy_path(response)
      end
    end

    describe 'when a request is made without a country present' do
      it 'selects a random country and returns a json response' do
        allow(CountriesFacade).to receive(:random_country).and_return("germany")
        get "/api/v1/recipes"
        
        happy_path(response)
      end
    end
  end

  describe 'sad path' do
    describe 'when the country param is blank' do
      it 'returns a json response with a key of data with empty array as value' do
        get "/api/v1/recipes?country="
        
        result = json(response)
        
        expect(result).to have_key(:data)
        
        data = result[:data]

        expect(data).to be_empty
      end
    end

    describe 'when country param points to nonexistent country or country with no recipes' do
      it 'returns a json response with empty data' do
        get "/api/v1/recipes?country=zbblegoodle"

        expect(response).not_to be_successful
        expect(response).to have_http_status(400)
        
        result = json(response)
        
        expect(result).to have_key(:errors)
      end
    end
  end
end

def happy_path(response)
  expect(response).to be_successful
  result = json(response)
  expect(result).to have_key(:data)

  data = result[:data]
  expect(result[:data]).to be_an Array

  if !result[:data].empty?
    result[:data].each do |recipe|
      expect(recipe).to have_key(:id)
      expect(recipe[:id]).to eq("null")
      expect(recipe).to have_key(:type)
      expect(recipe[:type]).to eq("recipe")
      expect(recipe).to have_key(:attributes)

      attributes = recipe[:attributes]
      expect(attributes).to have_key(:title)
      expect(attributes).to have_key(:url)
      expect(attributes).to have_key(:country)
      expect(attributes).to have_key(:image)

      expect(attributes).not_to have_key(:uri)
      expect(attributes).not_to have_key(:source)
      expect(attributes).not_to have_key(:yield)
      expect(attributes).not_to have_key(:ingredients)
    end
  end
end