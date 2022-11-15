class Api::V1::RecipesController < ApplicationController
  def index
    @country = params[:country]
    if !@country.nil? && (@country.blank? || not_a_country)
      render json: CustomSerializer.no_country, status: 400
    else 
      @country = random_country if @country.nil?
      recipes = RecipesFacade.search_recipes(@country)
      render json: RecipeSerializer.new(recipes)
    end
  end

  private

  def random_country
    CountriesFacade.random_country
  end

  def not_a_country
    !CountriesFacade.country_names.include?(@country.titleize)
  end
end
