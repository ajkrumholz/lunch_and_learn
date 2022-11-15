require 'rails_helper'

RSpec.describe CountriesFacade, type: :model do
  describe 'class methods', :vcr do
    describe '::random_country' do
      it 'returns a random country from REST country API' do
        expect(described_class.random_country).to be_a String
      end
    end

    describe '::country_names' do
      it 'returns a list of all countrys from REST country API' do
        result = described_class.country_names
        expect(result).to be_an Array
        expect(result.first).to be_a String
      end
    end
  end
end