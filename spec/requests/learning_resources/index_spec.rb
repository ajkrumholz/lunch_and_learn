require 'rails_helper'

RSpec.describe "learning_resources#index" do
  describe 'happy path' do
    describe 'when a request is made with a specific country' do
      it 'returns a json response' do
        country = 'laos'
        get "/api/v1/learning_resources?country=#{country}"
      end
    end
  end
end