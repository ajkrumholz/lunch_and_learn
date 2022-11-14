class Api::V1::TouristSightsController < ApplicationController
  def index
    sights = TouristSightsFacade.get_sights(params[:country])
    render json: TouristSightSerializer.new(sights)
  end
end