class CountriesFacade
  def self.random_country
    country_names.sample
  end

  def self.country_names
    response = RestCountriesService.all
    response.map { |country| country[:name] }
  end
end