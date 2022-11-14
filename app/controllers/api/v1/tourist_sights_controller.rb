class Api::V1::TouristSightsController < ApplicationController
  before_action :set_country, only: :index

  def index
    if @country == ""
      render json: CustomSerializer.no_content, status: 400
    else
      sights = TouristSightsFacade.get_sights(@country)
      render json: TouristSightSerializer.new(sights)
    end
  end

  private

  def set_country
    if params[:country].nil?
      @country = CountriesFacade.random_country
    else
      @country = params[:country]
    end
  end
end