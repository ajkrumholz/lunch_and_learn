class Api::V1::RecipesController < ApplicationController
  before_action :set_country, only: %i(index)
  
  def index
    if @country.blank?
      render json: CustomSerializer.no_content
    else
      recipes = RecipesFacade.search_recipes(@country)
      if recipes.empty?
        render json: CustomSerializer.no_content
      else
        render json: RecipeSerializer.new(recipes)
      end
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
