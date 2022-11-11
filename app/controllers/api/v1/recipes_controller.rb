class Api::V1::RecipesController < ApplicationController
  before_action :set_country, only: %i(index)
  
  def index
    recipes = RecipesFacade.search_recipes(@country)
    render json: RecipeSerializer.new(recipes)
  end

  def set_country
    if params[:country].blank?
      @country = CountriesFacade.random_country
    else
      @country = params[:country]
    end
  end
end
