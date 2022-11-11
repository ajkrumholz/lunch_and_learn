class CountriesFacade
  def self.random_country
    response = RestCountriesService.all
    name_array = response.map { |country| country[:name] }
    name_array.sample
  end
end