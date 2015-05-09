class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)
    @user.save
    render json: {status: 'OK', user_id: @user.id}
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(last_donated: Date.today)
    @user.save
    render json: {status: 'OK'}
  end

  private
  def user_params
      params.require(:user).permit(:name, :phone_number, :blood_group, :area, :latitude, :longitude, :last_donated)
  end
end
