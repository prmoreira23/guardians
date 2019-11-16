class UserController < ApplicationController
  def create
    User.find_or_create_by(user_params)
  end

  private
  def user_params
    params.permit(:email)
  end
end
