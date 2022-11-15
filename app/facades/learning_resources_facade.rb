class LearningResourcesFacade
  def self.search(country)
    video_data = convert_v(YoutubeApiService.search(country))
    image_data = convert_i(FlickrApiService.search(country))
    LearningResource.new(video_data, image_data, country)
  end

  private

  def self.convert_v(video_data)
    items = video_data[:items]
    return [] if items.empty?
    { 
      title: items.first[:snippet][:title],
      youtube_video_id: items.first[:id][:videoId]   
    }
  end

  def self.convert_i(image_data)
    photos = image_data[:photos][:photo]
    return [] if photos.empty?
    photos.inject([]) do |photo_array, photo|
      photo_array << { 
        alt_tag: photo[:title],
        url: photo[:url_c]
      }
    end
  end
end