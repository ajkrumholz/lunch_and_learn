class Api::V1::LearningResourcesController < ApplicationController
  before_action :set_country
  
  def index
    if !@country.nil? && @country.blank?
      render json: CustomSerializer.no_country, status: 400
    else
      @country = random_country if @country.nil?
      resources = LearningResourcesFacade.search(@country)
      render json: LearningResourceSerializer.new(resources)
    end
  end
end
