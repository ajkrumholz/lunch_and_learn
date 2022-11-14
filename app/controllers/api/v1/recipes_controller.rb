class Api::V1::RecipesController < ApplicationController
  before_action :set_country, only: %i(index)
  
  def index
    if @country.blank?
      render json: CustomSerializer.no_content, status: 400
    elsif not_a_country
      render json: CustomSerializer.no_country, status: 400
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

  def not_a_country
    !CountriesFacade.country_names.include?(@country.titleize)
  end
end
