require 'rails_helper'

RSpec.describe LearningResourcesFacade, :vcr do
  describe '::search_video(country)' do
    it 'returns a LearningResource object' do
      country = 'indonesia'
      result = described_class.search(country)
      expect(result).to be_a LearningResource

      expect(result.country).to eq(country)
      expect(result.id).to eq("null")
      expect(result.images).to be_an Array
      expect(result.video).to be_a Hash
    end
  end

  describe '::convert_v(video_data)' do
    it 'converts service response into hash for poro' do
      country = 'indonesia'
      hash = YoutubeApiService.search(country)

      expect(hash).to have_key(:items)

      result = described_class.convert_v(hash)
      expect(result).to be_a Hash
      expect(result).not_to have_key(:items)
      expect(result).to have_key(:title)
      expect(result).to have_key(:youtube_video_id)
    end
  end

  describe '::convert_i(image_data)' do
    it 'converts service response into array for poro' do
      country = 'indonesia'
      hash = FlickrApiService.search(country)

      expect(hash).to be_a Hash
      expect(hash).to have_key(:photos)
      expect(hash[:photos]).to have_key(:page)
      expect(hash[:photos]).to have_key(:photo)
      photo = hash[:photos][:photo].first

      expect(photo).to have_key(:id)
      expect(photo).to have_key(:owner)

      result = described_class.convert_i(hash)
      expect(result).to be_an Array
      expect(result.first).to be_a Hash
      expect(result.first).to have_key(:alt_tag)
      expect(result.first).to have_key(:url)
      expect(result.first).not_to have_key(:id)
      expect(result.first).not_to have_key(:owner)
    end
  end
end