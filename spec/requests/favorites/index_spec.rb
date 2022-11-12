require 'rails_helper'

RSpec.describe 'favorites#index' do
  let!(:user) { User.create!(name: 'Gordon Ramsay', email: 'hotsteaks@steakmoney.com') }
  let!(:favorite_1) { user.favorites.create!()}

  describe 'when a get request is made to /api/v1/favorites' do
    describe 'happy paths' do
      describe 'when a valid api key is provided' do
        it 'returns a json response containing all a users favorites' do

        end
      end
    end
  end
end