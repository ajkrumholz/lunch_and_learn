class Api::V1::LearningResourcesController < ApplicationController
  before_action :set_country, only: :index
  
  def index
    if @country.blank?
      render json: CustomSerializer.no_content
    else
      resources = LearningResourcesFacade.search_video(@country)
      # if resources.empty?
      #   render json: CustomSerializer.no_resource
      # else
        render json: LearningResourceSerializer.new(resources)
      # end
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
