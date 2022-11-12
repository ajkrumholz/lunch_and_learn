require 'rails_helper'

RSpec.describe CountriesFacade, type: :model do
  describe 'class methods', :vcr do
    describe '::random_country' do
      it 'returns a random country from REST country API' do
        expect(CountriesFacade.random_country).to be_a String
      end
    end
  end
end