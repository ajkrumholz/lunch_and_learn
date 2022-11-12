require 'rails_helper'

RSpec.describe RestCountriesService do
  describe 'class methods', :vcr do
    describe '::all' do
      it 'returns a json response containing info about countries' do
        countries = RestCountriesService.all

        country = countries.sample
        expect(country).to have_key(:name)
        expect(country).to have_key(:independent)
      end
    end
  end
end