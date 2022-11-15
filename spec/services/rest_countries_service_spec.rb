require 'rails_helper'

RSpec.describe RestCountriesService do
  before :each do 
    Rails.cache.clear
  end
    
  describe 'class methods', :vcr do
    describe '::all' do
      it 'returns a json response containing info about countries' do
        result = described_class.all
        expect(result).to be_an Array

        country = result.first
        expect(country).to be_a Hash
        expect(country).to have_key(:name)
        expect(country).to have_key(:independent)
      end
    end
  end
end