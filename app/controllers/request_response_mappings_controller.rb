class RequestResponseMappingsController < ApplicationController

  def my_responses
    active_request = BloodRequest.where(user_id: params[:user_id], active: true)
    user_ids = RequestResponseMapping.where(blood_request_id: active_request.first.id)
    responded_users = user_ids.collect { |i| User.find(i) }
    render json: responded_users
  end
end
