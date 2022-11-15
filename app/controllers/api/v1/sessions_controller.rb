class Api::V1::SessionsController < ApplicationController
  before_action :set_user

  def create
    if @user.nil?
      render json: CustomSerializer.no_auth
    elsif @user.authenticate(user_params[:password])
      render json: UserSerializer.new(@user)
    else
      render json: CustomSerializer.no_auth
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by(email: user_params[:email])
  end
end
