require 'rails_helper'

RSpec.describe 'user#create' do
  let!(:headers) { {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  } }

  describe 'happy path' do
    describe 'when a post request is sent' do
      
      it 'creates a user and returns a json response' do
        body = {
          'name': 'Roger Scrumfeather',
          'email': 'roger@scrumfeather.io',
          'password': 'password123',
          'password_confirmation': 'password123'
        }

        post('/api/v1/users', params: { user: body }.to_json, headers: headers)
        
        parsed_body = JSON.parse(body.to_json, symbolize_names: true)
        expect(User.last.name).to eq(parsed_body[:name])
        expect(User.last.email).to eq(parsed_body[:email])
        expect(User.last.api_key).to be_a String
        expect(User.last.api_key.length).to eq 20

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
        expect(attributes[:name]).to be_a String
        expect(attributes).to have_key(:email)
        expect(attributes[:email]).to be_a String
        expect(attributes).to have_key(:api_key)
        expect(attributes[:api_key]).to be_a String
      end
    end
  end

  describe 'sad path' do
    describe 'when user doesnt get a name' do
      it 'returns a json error response with status 400' do
        body = {
          'email': 'roger@scrumfeather.io',
          'password': 'abcdefg',
          'password_confirmation': 'abcdefg'
        }

        post('/api/v1/users', params: { user: body }.to_json, headers: headers)
        expect(response).not_to be_successful
        expect(response).to have_http_status(400)
        
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:errors)
      end
    end
    
    describe 'when user doesnt get an email' do
      it 'returns a json error response with status 400' do
        body = {
          'name': 'roger lawson',
          'password': 'abcdefg',
          'password_confirmation': 'abcdefg'
        }

        post('/api/v1/users', params: { user: body }.to_json, headers: headers)
        expect(response).not_to be_successful
        expect(response).to have_http_status(400)
        
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:errors)
      end
    end

    describe 'when a user tries to put in a duplicate email' do
      it 'returns an error response with status 400' do
        body = {
          'name': 'Roger Scrumfeather',
          'email': 'roger@scrumfeather.io',
          'password': 'some_password',
          'password_confirmation': 'some_password',
        }

        post('/api/v1/users', params: { user: body }.to_json, headers: headers)

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        body = {
          'name': 'Aylweather Scrumfeather',
          'email': 'roger@scrumfeather.io',
          'password': 'more_password',
          'password_confirmation': 'more_password'
        }

        post('/api/v1/users', params: { user: body }.to_json, headers: headers)

        expect(response).not_to be_successful
        expect(response).to have_http_status(400)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:errors)
        expect(result[:errors].first[:detail]).to include("Email has already been taken")
      end
    end

    describe 'when password confirmations dont match' do
      it 'returns an error' do
        body = {
          'name': 'Aylweather Scrumfeather',
          'email': 'roger@scrumfeather.io',
          'password': 'more_password',
          'password_confirmation': 'nomatch'
        }

        post('/api/v1/users', params: { user: body }.to_json, headers: headers)

        expect(response).not_to be_successful
        expect(response).to have_http_status(400)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:errors)
        expect(result[:errors].first[:source]).to eq("password_confirmation")
      end
    end
  end
end