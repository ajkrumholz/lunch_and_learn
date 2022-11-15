class LearningResource
  attr_reader :id,
              :country,
              :video,
              :images

  def initialize(video, images, country)
    @id = "null"
    @country = country
    @video = video
    @images = images
  end

  # def video
  #   return [] if @video_data[:items].empty?
  #   { 
  #     title: @video_data[:items].first[:snippet][:title],
  #     youtube_video_id: @video_data[:items].first[:id][:videoId]   
  #   }
  # end

  # def images
  #   return [] if @image_data[:photos][:photo].empty?
  #   @image_data[:photos][:photo].inject([]) do |array, photo|
  #     array << { 
  #       alt_tag: photo[:title],
  #       url: photo[:url_c]
  #     }
  #   end
  # end
end