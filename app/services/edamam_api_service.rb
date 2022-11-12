class EdamamApiService
  def self.conn
    Faraday.new(url: 'https://api.edamam.com') do |f|
      f.params['app_id'] = ENV['edamam_app_id']
      f.params['app_key'] = ENV['edamam_api_key']
    end
  end
  
  def self.search(country)
    response = search_uncached(country)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search_uncached(country)
    Rails.cache.fetch("recipes_#{country}", expires_in: 7.days) do
      conn.get("/search?q=#{country}")
    end
  end
end