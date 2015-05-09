class BloodRequestsController < ApplicationController

  def index
    render json: BloodRequest.all
  end
end
