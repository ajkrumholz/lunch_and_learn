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
end