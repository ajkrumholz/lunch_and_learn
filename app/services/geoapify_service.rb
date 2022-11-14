class GeoapifyService
  def self.conn
    Faraday.new("https://api.geoapify.com") do |f|
      f.params['apiKey'] = ENV['geoapify_key']
    end
  end

  def self.sights_near(long, lat)
    response = conn.get("/v2/places") do |f|
      f.params['filter'] = "circle:#{long},#{lat},20000"
      f.params['categories'] = "tourism.sights"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end