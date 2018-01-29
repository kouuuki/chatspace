class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def callback
   if params["hub.verify_token"] == "qwertyuiop"
      render json: params["hub.challenge"]
   else
      render json: "Error, wrong validation token"
   end
  end
end
