class RestCountriesService
  def self.conn
    Faraday.new("https://restcountries.com")
  end

  def self.all
    response = conn.get("/v2/all?fields=name")
    json(response)
  end
end