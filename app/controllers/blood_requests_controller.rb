require 'gcm'
class BloodRequestsController < ApplicationController
  include LocationHelper

  def index
    user_id = params[:user_id]
    all_requests = BloodRequest.all
    final_requests = []
    requests_generated_by_other_users = all_requests.select { |req| req.user_id != user_id.to_i && req.active == true }
    requests_generated_by_other_users.each { |req|
      final_requests.push({request: req, user: User.find(req.user_id)})
    }
    render json: final_requests
  end

  def create
    @blood_request = BloodRequest.new(blood_request_params)
    @blood_request.update_attributes!(active: true)
    @blood_request.save
    gcm = GCM.new("AIzaSyBFhjziCke8y5YXqFxzYhVQUpSOtnUT_eo")
    registration_ids= get_neighbouring_device_ids @blood_request
    options = {data: @blood_request}
    response = gcm.send(registration_ids, options)
    render json: {status: 'OK', blood_request_id: @blood_request.id, gcm_response: response}
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

  def get_neighbouring_device_ids(blood_request)
    registration_ids =[]
    users = User.all
    users = users.select{|user| user.id != blood_request.user_id}
    users.each { |user|
      distance = distance(user.latitude.to_f, user.longitude.to_f,
                          blood_request.latitude.to_f, blood_request.longitude.to_f)
      if distance < 100
        registration_ids.push(user.registration_id)
      end
    }
    registration_ids
  end
end
