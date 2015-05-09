class RequestResponseMapping < ActiveRecord::Base
  belongs_to :user
  belongs_to :blood_request
end
