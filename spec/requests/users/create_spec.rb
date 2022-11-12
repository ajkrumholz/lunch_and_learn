require 'rails_helper'

RSpec.describe 'user#create' do
  describe 'happy path' do
    describe 'when a post request is sent' do
      let!(:headers) { {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      } }
      
      it 'creates a user and returns a json response' do
        body = {
          'name': 'Roger Scrumfeather',
          'email': 'roger@scrumfeather.io'
        }

        post('/api/v1/users', params: { user: body }.to_json, headers: headers)
        
        parsed_body = JSON.parse(body.to_json, symbolize_names: true)
        expect(User.last.name).to eq(parsed_body[:name])
        expect(User.last.email).to eq(parsed_body[:email])

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:data)

        data = result[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:name)
        expect(attributes).to have_key(:email)
        expect(attributes).to have_key(:api_key)
      end
    end
  end
end