require 'rails_helper'

RSpec.describe LearningResource, :vcr do
  let!(:country) { "laos" }
  let!(:video) { {:title=>"A Super Quick History of Laos", :youtube_video_id=>"uw8hjVqxMXw"} }
  let!(:images) { [{:alt_tag=>"2022_11_14  (125)", :url=>"https://live.staticflickr.com/65535/52500754185_079c49a44d_c.jpg"},
    {:alt_tag=>"2022_11_14  (096)", :url=>"https://live.staticflickr.com/65535/52499783497_acd34f0494_c.jpg"},
    {:alt_tag=>"2022_11_14  (097)", :url=>"https://live.staticflickr.com/65535/52500270156_a5a0da9b92_c.jpg"},
    {:alt_tag=>"2022_11_14  (094)", :url=>"https://live.staticflickr.com/65535/52500825033_1a1892c3be_c.jpg"},
    {:alt_tag=>"2022_11_14  (116)", :url=>"https://live.staticflickr.com/65535/52500268826_110f38c7c5_c.jpg"},
    {:alt_tag=>"2022_11_14  (143)", :url=>"https://live.staticflickr.com/65535/52500549409_64d7d1b52b_c.jpg"},
    {:alt_tag=>"2022_11_14  (144)", :url=>"https://live.staticflickr.com/65535/52499779977_1eee7059bb_c.jpg"},
    {:alt_tag=>"2022_11_14  (145)", :url=>"https://live.staticflickr.com/65535/52499779812_ef0354ec9d_c.jpg"},
    {:alt_tag=>"2022_11_14  (138)", :url=>"https://live.staticflickr.com/65535/52499779677_f945b41556_c.jpg"},
    {:alt_tag=>"2022_11_14  (134)", :url=>"https://live.staticflickr.com/65535/52500742070_0da92d45fc_c.jpg"}] }
  let!(:resource) { described_class.new(video, images, country) }

  it 'has attributes' do
    expect(resource).to be_a described_class
    expect(resource.id).to eq("null")
    expect(resource.country).to eq(country)
    expect(resource.video).to be_a Hash
    expect(resource.images).to be_an Array
  end
end