class LearningResource
  attr_reader :id,
              :country

  def initialize(video_data, image_data, country)
    @id = "null"
    @country = country
    @video_data = video_data
    @image_data = image_data
  end

  def video
    return [] if @video_data[:items].empty?
    { 
      title: @video_data[:items].first[:snippet][:title],
      youtube_video_id: @video_data[:items].first[:id][:videoId]   
    }
  end

  def images
    return [] if @image_data[:photos][:photo].empty?
    @image_data[:photos][:photo].inject([]) do |array, photo|
      array << { 
        alt_tag: photo[:title],
        url: photo[:url_c]
      }
    end
  end
end