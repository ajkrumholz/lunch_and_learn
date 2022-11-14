require 'rails_helper'

RSpec.describe 'favorites#delete' do
  let!(:user) { create :user }
  let!(:favorites) { create_list(:favorite, 5, user: user)}
  let!(:target) { favorites.last }
  let!(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

  before { user.assign_api_key }

  describe 'when a delete request is made to /api/v1/favorites/:favorite_id' do
    describe 'happy_path' do
      let!(:body) { { user: { api_key: user.api_key } } }

      describe 'when a valid favorite_id is provided' do
        it 'deletes the record and returns a 204 response' do
          expect(Favorite.all.count).to eq 5
          expect(Favorite.all).to include(target)

          delete "/api/v1/favorites/#{target.id}", params: body.to_json, headers: headers

          expect(Favorite.all.count).to eq(4)
          expect(Favorite.all).not_to include(target)

          expect(response).to be_successful
          expect(response).to have_http_status(204)
        end
      end
    end

    describe 'sad path' do
      describe 'when an api key is not provided' do
        it 'throws a 401 error' do
          delete "/api/v1/favorites/#{target.id}", params: body.to_json, headers: headers

          expect(response).not_to be_successful
          expect(response).to have_http_status(401)
        end
      end

      describe 'when a bad api key is provided' do
        let!(:body) { { user: { api_key: 'very bad no good api key' } } }

        it 'throws a 401 error' do
          delete "/api/v1/favorites/#{target.id}", params: body.to_json, headers: headers
          
          expect(response).not_to be_successful
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end