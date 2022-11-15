require 'rails_helper'

RSpec.describe 'sessions#create' do
  describe 'when a post request is sent to /api/v1/sessions' do
    describe 'happy paths' do
      let!(:user) { create :user, password: "keyboard", password_confirmation: "keyboard"}
      let!(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json'}}

      describe 'when a user logs in and puts in the correct password' do
        it 'creates a new session for the user' do
          user.assign_api_key
          body = { 
            user: 
              { 
                email: user.email, 
                password: "keyboard" 
              } 
                 }

          post '/api/v1/sessions', params: body.to_json, headers: headers

          expect(response).to be_successful

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:data)
          
          data = result[:data]
          expect(data).to have_key(:type)
          expect(data[:type]).to eq("user")
          expect(data).to have_key(:id)
          expect(data[:id]).to eq(user.id.to_s)
          expect(data).to have_key(:attributes)

          attributes = data[:attributes]
          expect(attributes).to be_a Hash
          expect(attributes).to have_key(:name)
          expect(attributes[:name]).to eq(user.name.to_s)
          expect(attributes).to have_key(:email)
          expect(attributes[:email]).to eq(user.email.to_s)
          expect(attributes).to have_key(:api_key)
          expect(attributes[:api_key]).to eq(user.api_key.to_s)
        end
      end
    end
  end
end