require 'rails_helper'

RSpec.describe 'recipes#index', :vcr do
  describe 'happy path' do
    describe 'when a request is made to api/v1/recipes?country={country}' do
      it 'returns a json response' do
        country = "thailand"

        get "/api/v1/recipes?country=#{country}"
        
        expect(response).to be_successful

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:data)

        data = result[:data]
        expect(result[:data]).to be_an Array

        result[:data].each do |recipe|
          expect(recipe).to have_key(:id)
          expect(recipe[:id]).to eq("null")
          expect(recipe).to have_key(:type)
          expect(recipe[:type]).to eq("recipe")
          expect(recipe).to have_key(:attributes)

          attributes = recipe[:attributes]
          expect(attributes).to have_key(:id)
          expect(attributes).to have_key(:url)
          expect(attributes).to have_key(:country)
          expect(attributes).to have_key(:image)
        end
      end
    end
  end
end