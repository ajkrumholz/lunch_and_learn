require 'rails_helper'

RSpec.describe 'favorites#index' do
  let!(:user) { create :user }
  let!(:favorites) { create_list(:favorite, 5, user: user ) }
  let!(:other_user) { create :user }
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
            'api_key': user.api_key
          }

          get('/api/v1/favorites', params: { favorite: body }, headers: headers)

          expect(response).to be_successful
          expect(response).to have_http_status(200)
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to have_key(:data)

          data = result[:data]
          expect(data).to be_an Array

          favorite = data.first
          expect(favorite).to have_key(:id)
          expect(favorite).to have_key(:type)
          expect(favorite[:type]).to eq('favorite')
          expect(favorite).to have_key(:attributes)

          attributes = favorite[:attributes]
          expect(attributes).to have_key(:recipe_title)
          expect(attributes[:recipe_title]).to be_a String
          expect(attributes).to have_key(:recipe_link)
          expect(attributes[:recipe_link]).to be_a String
          expect(attributes).to have_key(:country)
          expect(attributes[:country]).to be_a String
          expect(attributes).to have_key(:created_at)
          expect(attributes[:created_at]).to be_a String
        end

        it 'returns an empty data response if user has no favorites' do
          other_user.assign_api_key

          body = {
            'api_key': other_user.api_key
          }

          get('/api/v1/favorites', params: { favorite: body }, headers: headers)

          expect(response).to be_successful
          expect(response).to have_http_status(200)
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to have_key(:data)
          expect(result[:data]).to be_empty
        end
      end
    end

    describe 'sad paths' do
      describe 'when a bad api key is sent' do
        it 'returns a 401 error' do
          other_user.assign_api_key

          body = {
            'api_key': 'bad key'
          }

          get('/api/v1/favorites', params: { favorite: body }, headers: headers)

          expect(response).not_to be_successful
          expect(response).to have_http_status(401)
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to have_key(:errors)
          expect(result[:errors]).to include("API Key could not be verified")
        end
      end

      describe 'when api key sent as query param' do
        it 'returns a 401 error' do
          get("/api/v1/favorites?api_key=#{user.api_key}")

          expect(response).not_to be_successful
          expect(response).to have_http_status(401)
          
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to have_key(:errors)
          expect(result[:errors]).to include("API Key could not be verified")
        end
      end
    end
  end
end