require 'rails_helper'

RSpec.describe 'tourist_sights#index', :vcr do
  describe 'happy path' do
    describe 'when a GET request is made to /api/v1/tourist_sights' do
      it 'returns a list of tourist sights within 20k meters of a country capitol city' do
        country = 'latvia'
        
        get "/api/v1/tourist_sights?country=#{country}"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:data)
        expect(result[:data]).not_to be_empty
        expect(result[:data]).to be_an Array

        first_result = result[:data].first
        expect(first_result).to have_key(:id)
        expect(first_result[:id]).to eq('null')
        expect(first_result).to have_key(:type)
        expect(first_result[:type]).to eq('tourist_sight')
        expect(first_result).to have_key(:attributes)

        attributes = first_result[:attributes]
        expect(attributes).to be_a Hash
        expect(attributes).to have_key(:name)
        expect(attributes).to have_key(:address)
        expect(attributes).to have_key(:place_id)
      end

      describe 'when country param is omitted' do
        it 'searches a random country instead' do

        allow(CountriesFacade).to receive(:random_country).and_return("france")
        get "/api/v1/tourist_sights"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:data)
        expect(result[:data]).not_to be_empty
        expect(result[:data]).to be_an Array

        first_result = result[:data].first
        expect(first_result).to have_key(:id)
        expect(first_result[:id]).to eq('null')
        expect(first_result).to have_key(:type)
        expect(first_result[:type]).to eq('tourist_sight')
        expect(first_result).to have_key(:attributes)

        attributes = first_result[:attributes]
        expect(attributes).to be_a Hash
        expect(attributes).to have_key(:name)
        expect(attributes).to have_key(:address)
        expect(attributes).to have_key(:place_id)
        end
      end
    end
  end

  describe 'sad path' do
    describe 'when country parameter is blank' do
      it 'returns a 400 error and a blank response' do
        get "/api/v1/tourist_sights?country="

        expect(response).not_to be_successful
        expect(response).to have_http_status(400)
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data]).to be_empty
      end
    end

    describe 'when a country is typed incorrectly' do
      it 'returns an empty response but no error' do
        get "/api/v1/tourist_sights?country=@!KFJDKJ"

        expect(response).to be_successful
        expect(response).to have_http_status(200)
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data]).to be_empty
      end
    end
  end
end