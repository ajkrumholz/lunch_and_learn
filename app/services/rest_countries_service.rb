class RestCountriesService
  def self.conn
    Faraday.new("https://restcountries.com")
  end

  def self.all
    response = all_uncached
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.all_uncached
    Rails.cache.fetch("all_countries", expires_in: 30.days) do
      conn.get("/v2/all?fields=name")
    end
  end

  def self.details(country)
    response = conn.get("/v3.1/name/#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end
end