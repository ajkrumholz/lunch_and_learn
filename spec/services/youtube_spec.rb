require 'rails_helper'

RSpec.describe YoutubeApiService, :vcr do
  before :each do 
    Rails.cache.clear
  end
    
  describe 'it searches the mr. history channel for a video on a country' do
    describe '::search(country)' do
      it 'returns a json response' do
        country = "poland"
        result = described_class.search(country)

        expect(result).to have_key(:items)
        items = result[:items]

        expect(items).to be_an Array

        item = items.first
        expect(item).to be_a Hash
        expect(item).to have_key(:id)

        id = item[:id]
        expect(id).to be_a Hash
        expect(id[:videoId]).to be_a String

        snippet = item[:snippet]
        expect(snippet).to be_a Hash
        expect(snippet[:title]).to be_a String

        expect(result).not_to have_key(:kind)
        expect(result).not_to have_key(:etag)
        expect(result).not_to have_key(:nextPageToken)
        expect(result).not_to have_key(:regionCode)
        expect(result).not_to have_key(:pageInfo)

        expect(item).not_to have_key(:kind)
        expect(item).not_to have_key(:etag)
      end

      describe 'if no results found' do
        it 'returns an empty response' do
          country = "sadfkj2"
          result = described_class.search(country)
          expect(result).to have_key(:items)
          
          items = result[:items]
          expect(items).to be_an Array
          expect(items).to be_empty
        end
      end
    end
  end
end