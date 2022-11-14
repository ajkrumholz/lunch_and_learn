class GeoapifyService
  def self.conn
    Faraday.new("https://api.geoapify.com") do |f|
      f.params['apiKey'] = ENV['geoapify_key']
    end
  end

  def self.places_api
    response = conn.get("/v2/places?PARAMS")
    JSON.parse(response.body)
  end

  def self.geocoding_api
    response = conn.get("/v1/geocode/search?REQUEST_PARAMS")
    JSON.parse(response.body)
  end
end