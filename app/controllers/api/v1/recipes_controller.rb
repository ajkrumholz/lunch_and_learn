class Api::V1::RecipesController < ApplicationController
  before_action :set_country, only: %i(index)
  
  def index
    if @country.blank?
      render json: { data: [] }
    else
      recipes = RecipesFacade.search_recipes(@country)
      render json: RecipeSerializer.new(recipes)
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
