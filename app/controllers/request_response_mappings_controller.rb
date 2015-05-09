class RequestResponseMappingsController < ApplicationController
  include LocationHelper

  def create
    request_response_mapping = RequestResponseMapping.new({user_id: params[:user_id],
                                                           blood_request_id: params[:request_id]})
    request_response_mapping.save
    render json: {status: 'OK'}
  end

  def my_responses
    active_request = BloodRequest.where(user_id: params[:user_id], active: true).first
    filtered_request_responses = RequestResponseMapping.where(blood_request_id: active_request.id)
    responded_users = filtered_request_responses.collect { |mapping|
      User.find(mapping.user_id)
    }
    render json: {active_request: active_request, responses: responded_users}
  end

  def my_requests
    blood_grouping = {
        'A+' => %w(A+ A- O+ O-),
        'O+' => %w(O+ O-),
        'B+' => %w(B+ B- O+ O-),
        'AB+' => %w(A+ B+ A- B- O+ O- AB+ AB-),
        'A-' => %w(A- O-),
        'O-' => %w(O-),
        'B-' => %w(B- O-),
        'AB-' => %w(AB- A- B- O-),
    }

    user = User.find(params[:user_id])
    my_requests = []
    if (user.last_donated && months(Date.today, user.last_donated) <= 3)
      return render json: {my_requests: my_requests}
    end
    all_active_requests = BloodRequest.where({active: true})
    all_other_active_requests = all_active_requests.select { |req| req.user_id != user.id }
    all_other_active_requests.each { |req|
      requested_user = User.find(req.user_id)
      if blood_grouping[req.blood_group].include?(user.blood_group)
        distance = distance(user.latitude.to_f, user.longitude.to_f,
                            requested_user.latitude.to_f, requested_user.longitude.to_f)
        if distance < 100
          my_requests.push({request: req, user: requested_user})
        end
      end
    }
    render json: my_requests
  end

  private
  def months(date1, date2)
    (date1.year*12+date1.month) - (date2.year*12+date2.month)
  end
end
