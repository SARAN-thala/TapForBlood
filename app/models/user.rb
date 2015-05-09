class User < ActiveRecord::Base
  has_many :blood_requests
end
