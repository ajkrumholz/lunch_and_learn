require 'rails_helper'

RSpec.describe 'favorites#index' do
  let!(:user) { create :user }
  let!(:favorites) { create_list(:favorite, 5, user: user ) }
  let!(:headers) { {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  } }

  describe 'when a get request is made to /api/v1/favorites' do
    describe 'happy paths' do
      describe 'when a valid api key is provided' do
        it 'returns a json response containing all a users favorites' do
          user.assign_api_key

          body = {
            api_key: user.api_key
          }

          get '/api/v1/favorites', params: body.to_json, headers: headers

          expect(response).to be_successful
          expect(response).to have_http_status(200)
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to have_key(:data)

          data = result[:data]
          expect(data).to have_key(:id)
          expect(data).to have_key(:type)
          expect(data[:type]).to eq('favorite')
          expect(data).to have_key(:attributes)

          attributes = data[:attributes]
          expect(attributes).to have_key(:recipe_title)
          expect(attributes[:recipe_title]).to be_a String
          expect(attributes).to have_key(:recipe_link)
          expect(attributes[:recipe_link]).to be_a String
          expect(attributes).to have_key(:country)
          expect(attributes[:country]).to be_a String
          expect(attributes).to have_key(:created_at)
          expect(attributes[:created_at]).to be_a String
        end
      end
    end
  end
end