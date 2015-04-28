class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include Authenticable
  include SessionContainer

  Rails.logger = Logger.new(STDOUT)
  
  def current_doctor 
    auth_token = request.headers['Authorization']
    if auth_token
      @current_doctor ||= Doctor.find_by(auth_token: auth_token)
    else
      logger.debug "AUTHTOKEN: " + session[:hygea_key].to_s
      @current_doctor ||= Doctor.find_by(auth_token: session[:hygea_key])
    end
  end
  
end
