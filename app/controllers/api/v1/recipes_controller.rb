class Api::V1::RecipesController < ApplicationController
  def index
    recipes = RecipesFacade.search_recipes(params[:country])
    render json: RecipeSerializer.new(recipes)
  end
end
