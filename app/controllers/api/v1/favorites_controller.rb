class Api::V1::FavoritesController < ApplicationController
  before_action :set_user, only: %i(index create)

  def index
    if @user.nil?
      render json: CustomSerializer.bad_api_key, status: 401
    else
      favorites = @user.favorites
      render json: FavoriteSerializer.new(favorites)
    end
  end
  
  def create
    if @user.nil?
      render json: CustomSerializer.bad_api_key, status: 401
    else
      fav = @user.favorites.new(fav_params)
      if fav.save
        render json: CustomSerializer.favorite_success, status: 201
      else
        render json: CustomSerializer.errors(fav.errors), status: 400
      end
    end
  end

  private

  def fav_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end

  def set_user
    if !params[:favorite].nil?
      @user = User.find_by_key(params[:favorite][:api_key])
    end
  end
end