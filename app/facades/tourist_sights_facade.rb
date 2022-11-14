class TouristSightsFacade
  def self.get_sights(country)
    lat_long = get_lat_long(country)
    long = lat_long[1]
    lat = lat_long[0]
    response = GeoapifyService.sights_near(long, lat)
    response[:features].map { |sight_data| TouristSight.new(sight_data) }
  end

  def self.get_lat_long(country)
    response = RestCountriesService.details(country)
    response.first[:latlng]
  end
end