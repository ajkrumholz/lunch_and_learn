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
end