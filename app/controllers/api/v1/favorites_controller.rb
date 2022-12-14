class Api::V1::FavoritesController < ApplicationController
  before_action :set_user

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

  def destroy
    if @user.nil?
      render json: CustomSerializer.bad_api_key, status: 401
    else
      fav = @user.favorites.find_by(id: params[:id])
      if fav.nil?
        render json: CustomSerializer.no_record, status: 404
      else
        fav.destroy
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:api_key)
  end

  def fav_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end

  def set_user
    if params[:user].present?
      @user = User.find_by(api_key: user_params[:api_key])
    end
  end
end