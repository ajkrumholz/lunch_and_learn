require 'rails_helper'

RSpec.describe "learning_resources#index", :vcr do
  describe 'happy path' do
    describe 'when a request is made with a specific country' do
      it 'returns a json response' do
        country = 'laos'
        get "/api/v1/learning_resources?country=#{country}"
        result = json(response)
        expect(result).to have_key(:data)

        data = result[:data]
        expect(data).to be_a Hash
        expect(data).not_to be_empty

        expect(data).to have_key(:id)
        expect(data[:id]).to eq("null")
        expect(data).to have_key(:type)
        expect(data[:type]).to eq("learning_resource")
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:country)
        expect(attributes).to have_key(:video)

        video = attributes[:video]
        expect(video).to have_key(:title)
        expect(video).to have_key(:youtube_video_id)

        expect(attributes).to have_key(:images)

        images = attributes[:images]
        images.each do |image|
        expect(image).to have_key(:alt_tag)
        expect(image).to have_key(:url)
        end
      end
    end

    describe 'when country param is omitted' do
      it 'searches a random country instead' do
        allow(CountriesFacade).to receive(:random_country).and_return("germany")

        get "/api/v1/learning_resources"
        result = json(response)
        expect(result).to have_key(:data)

        data = result[:data]
        expect(data).to be_a Hash
        expect(data).not_to be_empty

        expect(data).to have_key(:id)
        expect(data[:id]).to eq("null")
        expect(data).to have_key(:type)
        expect(data[:type]).to eq("learning_resource")
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:country)
        expect(attributes).to have_key(:video)

        video = attributes[:video]
        expect(video).to have_key(:title)
        expect(video).to have_key(:youtube_video_id)

        expect(attributes).to have_key(:images)

        images = attributes[:images]
        images.each do |image|
        expect(image).to have_key(:alt_tag)
        expect(image).to have_key(:url)
        end
      end
    end
  end

  describe 'sad path' do
    describe 'when country param is blank' do

    end

    describe 'when country param returns no results' do

    end
  end
end