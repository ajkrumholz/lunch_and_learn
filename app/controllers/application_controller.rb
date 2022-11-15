class ApplicationController < ActionController::API
  def random_country
    CountriesFacade.random_country
  end

  def not_a_country
    !CountriesFacade.country_names.include?(@country.titleize)
  end

  def set_country
    @country = params[:country]
  end
end
