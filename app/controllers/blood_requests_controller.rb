class BloodRequestsController < ApplicationController

  def index
    user_id = params[:user_id]
    all_requests = BloodRequest.all
    requests_generated_by_other_users = all_requests.select{|req| req.user_id != user_id.to_i && req.active == true}
    render json: requests_generated_by_other_users
  end

  def destroy
    blood_request = BloodRequest.find(params[:id])
    blood_request.update_attributes!(active: false)
    blood_request.save
    render json: {status: 'OK'}
  end
end
