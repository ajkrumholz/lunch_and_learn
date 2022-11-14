require 'rails_helper'

RSpec.describe 'tourist_sights#index' do
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
      end
    end
  end
end