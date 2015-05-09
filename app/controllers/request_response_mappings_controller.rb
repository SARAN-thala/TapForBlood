class RequestResponseMappingsController < ApplicationController

  def my_responses
    active_request = BloodRequest.where(user_id: params[:user_id], active: true).first
    user_ids = RequestResponseMapping.where(blood_request_id: active_request.id)
    responded_users = user_ids.collect { |i| User.find(i) }
    render json: {active_request: active_request, responses: responded_users}
  end
end
