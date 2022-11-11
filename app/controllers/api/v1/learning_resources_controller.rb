class Api::V1::LearningResourcesController < ApplicationController
  def index
    resources = LearningResourcesFacade.search_video(params[:country])
    render json: LearningResourceSerializer.new(resources)
  end
end
