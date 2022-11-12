class CountriesFacade
  def self.random_country
    response = fetch_country_list
    name_array = response.map { |country| country[:name] }
    name_array.sample
  end
  
  def self.fetch_country_list
    Rails.cache.fetch('country list', expires_in: 30.days) do
      RestCountriesService.all
    end
  end
end