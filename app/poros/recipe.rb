class Recipe
  attr_reader :title,
              :url,
              :image,
              :country,
              :id

  def initialize(data, country)
    @id = "null"
    @title = data[:recipe][:label]
    @url = data[:recipe][:url]
    @image = data[:recipe][:image]
    @country = country
  end
end