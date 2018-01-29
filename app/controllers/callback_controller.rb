class CallbackController < ApplicationController
  def callback
    if params["hub.verify_token"] == "hogehoge"
      # render json: params["hub.challenge"]
      render json: "Error, wrong validation token"
    else
      render json: "Error, wrong validation token"
    end
  end
end
