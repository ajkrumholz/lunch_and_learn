require 'rails_helper'

RSpec.describe 'favorites#create', :vcr do
  let!(:user) { create :user }
  let!(:country) { 'germany' }
  let!(:recipe) { RecipesFacade.search_recipes(country).first }
  let!(:headers) { {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  } }

  describe 'when a post request is sent to /api/v1/favorites' do
    describe 'happy path' do
      it 'returns a json response' do
        user.assign_api_key

        body = { 
          user: { api_key: user.api_key },
          favorite: 
            {
              country: country,
              recipe_link: recipe.url,
              recipe_title: recipe.title
            }
        }

        post("/api/v1/favorites", params: body.to_json, headers: headers)

        new_fav = Favorite.last
        expect(new_fav.user).to eq(user)
        expect(new_fav.country).to eq(country)
        expect(new_fav.recipe_link).to eq(recipe.url)
        expect(new_fav.recipe_title).to eq(recipe.title)

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:success)
        expect(result[:success]).to eq("Favorite added successfully")
      end
    end

    describe 'sad path' do
      describe 'when an invalid api key is provided' do
        it 'returns a 401 status with message' do
          user.assign_api_key

          body = { 
            user: { api_key: "bad key" },
            favorite: 
              {
                country: country,
                recipe_link: recipe.url,
                recipe_title: recipe.title
              }
          }

          post("/api/v1/favorites", params: body.to_json, headers: headers)

          expect(response).not_to be_successful
          expect(response).to have_http_status(401)

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to have_key(:errors)
          expect(result[:errors]).to include("API Key could not be verified")
        end
      end

      describe 'when a body attribute is not provided' do
        it 'returns a 400 status' do
          user.assign_api_key

          body = { 
            user: { api_key: user.api_key },
            favorite: 
              {
                country: country
              }
          }

          post("/api/v1/favorites", params: body.to_json, headers: headers)

          expect(response).not_to be_successful
          expect(response).to have_http_status(400)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:errors)
          expect(result[:errors].first[:source]).to eq('recipe_link')
          expect(result[:errors].second[:source]).to eq('recipe_title')
        end
      end
    end
  end
end