module Authenticable

  # def current_doctor
#     auth_token = request.headers['Authorization']
#     if auth_token
#       @current_doctor ||= Doctor.find_by(auth_token: auth_token)
#     else
#       logger.debug "AUTHTOKEN: " + SessionsController.restore_key
#       @current_doctor ||= Doctor.find_by(auth_token: SessionsController.restore_key)
#     end
#   end

  def current_personnel
  	@current_personnel ||= Personnel.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_doctor_with_token!
    if params[:controller] == 'dashboard'
      redirect_to '/sign_in' unless current_doctor.present?
    else
      render json: { errors: "Not authenticated" }, status: :unauthorized unless current_doctor.present?
    end
  end

  def authenticate_personnel_with_token!
  	render json: { errors: "Not authenticated" }, status: :unauthorized unless current_personnel.present?
  end

  def doctor_signed_in?
    current_doctor.present?
  end

  def personnel_signed_in?
  	current_personnel.present?
  end

end
