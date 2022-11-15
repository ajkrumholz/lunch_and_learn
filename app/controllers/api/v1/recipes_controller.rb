class Api::V1::RecipesController < ApplicationController
  before_action :set_country

  def index
    if !@country.nil? && (@country.blank? || not_a_country)
      render json: CustomSerializer.no_country, status: 400
    else 
      @country = random_country if @country.nil?
      recipes = RecipesFacade.search_recipes(@country)
      render json: RecipeSerializer.new(recipes)
    end
  end
end
