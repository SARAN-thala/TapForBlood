require 'gcm'
require 'twilio-ruby'
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
    # gcm_response = gcm_notification @blood_request
    parse_notification @blood_request
    sms_notification @blood_request
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

  def get_neighbouring_phone_numbers(blood_request)
    phone_numbers =[]
    users = User.all
    users = users.select{|user| user.id != blood_request.user_id}
    users.each { |user|
      distance = distance(user.latitude.to_f, user.longitude.to_f,
                          blood_request.latitude.to_f, blood_request.longitude.to_f)
      if distance < 100
        phone_numbers.push(user.phone_number)
      end
    }
    phone_numbers
  end

  def gcm_notification(blood_request)
    gcm = GCM.new("AIzaSyBFhjziCke8y5YXqFxzYhVQUpSOtnUT_eo")
    registration_ids= get_neighbouring_device_ids blood_request
    options = {data: blood_request}
    response = gcm.send(registration_ids, options)
    response
    end

  def parse_notification(blood_request)
    # registration_ids= get_neighbouring_device_ids blood_request
    Parse.init :application_id => "VwigJVwni2KiQ0Mq3GvnmZdVC3m72F2AL4Z0vRQI",
                            :api_key => "f1u42HkY3rzmMSVsWsL0PLynFw48zBJr84wKmkeI",
                            :quiet => false
    push = Parse::Push.new({ "alert"=> "Tap to save life" })
    push.where = {}
    push.save
    response
    end

  def sms_notification(blood_request)
    phone_numbers= get_neighbouring_phone_numbers blood_request
    account_sid = 'ACf989f9e9cc83c85befc6453a48014195'
    auth_token = '2821ea20eb96977a9ab433024934c068'
    @client = Twilio::REST::Client.new account_sid, auth_token

    user = User.find(blood_request.user_id)
    phone_numbers.each { |number|
      @client.account.messages.create({:body => "Blood Needed to save life. Contact #{user.name} - #{user.phone_number}",
                                                :to => "+919003240109",:from => "+19149203684"})
    }
  end
end
