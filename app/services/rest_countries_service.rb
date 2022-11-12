class RestCountriesService
  def self.conn
    Faraday.new("https://restcountries.com")
  end

  def self.all
    Rails.cache.fetch("countries list", expires_in: 30.days) do
      response = conn.get("/v2/all?fields=name")
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end