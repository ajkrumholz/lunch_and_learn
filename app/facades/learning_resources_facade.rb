class LearningResourcesFacade
  def self.search(country)
    video_data = YoutubeApiService.search(country)
    image_data = FlickrApiService.search(country)
    LearningResource.new(video_data, image_data, country)
  end
end