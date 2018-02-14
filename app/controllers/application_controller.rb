class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  # before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def callback
   if params["hub.verify_token"] == "qwertyuiop"
      render json: params["hub.challenge"]
   else
      render json: "Error, wrong validation token"
   end
  end
end
