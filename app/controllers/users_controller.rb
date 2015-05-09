class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.save
    render json: {status: 'OK'}
  end

  private
  def user_params
      params.require(:user).permit(:name, :phone_number, :blood_group, :area, :latitude, :longitude, :last_donated)
  end
end
