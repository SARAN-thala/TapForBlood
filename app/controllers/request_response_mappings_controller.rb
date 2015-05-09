class RequestResponseMappingsController < ApplicationController

  def my_responses
    active_request = BloodRequest.where(user_id: params[:user_id], active: true).first
    user_ids = RequestResponseMapping.where(blood_request_id: active_request.id)
    responded_users = user_ids.collect { |i| User.find(i) }
    render json: {active_request: active_request, responses: responded_users}
  end

  def my_requests
    user = User.find(params[:user_id])
    if (months(Date.today, user.last_donated) <= 3)
      render json: []
    end
    all_active_requests = BloodRequest.where({active: true})
    all_other_active_requests = all_active_requests.select { |req| req.user_id != user.id }
    my_requests = []
    all_other_active_requests.each { |req|
      requested_user = User.find(req.user_id)
      distance = distance(user.latitude.to_f, user.longitude.to_f,
                          requested_user.latitude.to_f, requested_user.longitude.to_f)
      if distance < 100
        my_requests.push(requested_user)
      end
    }
    render json: my_requests
  end

  private
  def distance(lat1, lon1, lat2, lon2)
    @ConstantR = 6371;
    dLat = (lat2-lat1) * Math::PI / 180;
    dLon = (lon2-lon1) * Math::PI / 180;
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    d = @ConstantR * c;
    if (d>1)
      return d.round;
    elsif (d<=1)
      return (d*1000).round;
    else
      return d;
    end
  end

  def months(date1, date2)
    (date1.year*12+date1.month) - (date2.year*12+date2.month)
  end
end
