require 'rails_helper'

RSpec.describe FlickrApiService, :vcr do
  describe 'it searches the flickr api for images' do
    describe '::search(country)' do
      it 'returns 10 photos for use by FE team' do
        country = 'bermuda'
        result = described_class.search(country)
        expect(result).to have_key(:photos)
        
        photos = result[:photos]
        expect(photos).to be_a Hash
        expect(photos).to have_key(:page)
        expect(photos).to have_key(:pages)
        expect(photos).to have_key(:perpage)
        expect(photos).to have_key(:total)
        expect(photos).to have_key(:photo)

        photo = photos[:photo]
        expect(photo).to be_an Array
        expect(photo.size).to eq(10)

        first_photo = photo.first
        expect(first_photo).to have_key(:id)
        expect(first_photo[:id]).to be_a String
        expect(first_photo).to have_key(:owner)
        expect(first_photo[:owner]).to be_a String
        expect(first_photo).to have_key(:secret)
        expect(first_photo[:secret]).to be_a String
        expect(first_photo).to have_key(:server)
        expect(first_photo[:server]).to be_a String
        expect(first_photo).to have_key(:farm)
        expect(first_photo[:farm]).to be_an Integer
        expect(first_photo).to have_key(:title)
        expect(first_photo[:title]).to be_a String
        expect(first_photo).to have_key(:url_c)
        expect(first_photo[:url_c]).to be_a String
        expect(first_photo).to have_key(:height_c)
        expect(first_photo[:height_c]).to be_an Integer
        expect(first_photo).to have_key(:width_c)
        expect(first_photo[:width_c]).to be_an Integer
      end

      describe 'if no results are found' do
        it 'returns an empty response' do
          country = "||||"
          result = described_class.search(country)
          expect(result).to have_key(:photos)

          photos = result[:photos]
          expect(photos[:photo]).to be_an Array
          expect(photos[:photo]).to be_empty
        end
      end
    end
  end
end