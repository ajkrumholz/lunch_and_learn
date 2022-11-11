class EdamamApiService
  def self.conn
    Faraday.new(url: 'https://api.edamam.com') do |faraday|
      faraday.params['app_id'] = ENV['edamam_app_id']
      faraday.params['app_key'] = ENV['edamam_api_key']
    end
  end
  
  def self.search(country)
    response = conn.get("/search?q=#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end
end