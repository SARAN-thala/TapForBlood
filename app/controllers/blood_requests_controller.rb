class BloodRequestsController < ApplicationController

  def index
    user_id = params[:user_id]
    all_requests = BloodRequest.all
    requests_generated_by_other_users = all_requests.select{|req| req.user_id != user_id.to_i && req.active == true}
    render json: requests_generated_by_other_users
  end

  def create
    @blood_request = BloodRequest.new(blood_request_params)
    @blood_request.update_attributes!(active: true)
    @blood_request.save
    render json: {status: 'OK', blood_request_id: @blood_request.id}
  end

  def destroy
    blood_request = BloodRequest.find(params[:id])
    blood_request.update_attributes!(active: false)
    blood_request.save
    render json: {status: 'OK'}
  end

  private
  def blood_request_params
    params.require(:blood_request).permit(:user_id, :blood_group, :area, :latitude, :longitude)
  end
end
