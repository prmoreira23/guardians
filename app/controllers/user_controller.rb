class UserController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :ok
    else
      head :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:email)
  end
end
