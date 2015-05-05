class DoctorsController < ApplicationController
	before_action :authenticate_doctor_with_token!, only: [:update, :destroy]

  def show
    respond_with Doctor.find(params[:id])
  end

  def create
    doctor = Doctor.create(doctor_params)

    logger.debug 'Params: ' + doctor_params.inspect
    logger.debug 'Doctor Object: ' + doctor.attributes.inspect

    if doctor.save
      #session[:hygea_key] = doctor.auth_token
      redirect_to root_path
    else
      render json: { errors: doctor.errors}, status: 422
    end
  end

  def update
    doctor = current_doctor

    if user.update(doctor_params)
      render json: doctor, status: 200, location: [:api, doctor]
    else
      render json: { errors: doctor.errors }, status: 422
    end
  end

  def destroy
    current_doctor.destroy
    head 204
  end

  def create_doctor

  end

  def show_doctor
    doctor_id = params[:id]
    
    @doctor = Doctor.find_by(id: doctor_id)
  end

  private

  def doctor_params
    logger.debug 'Provided Params: ' + params.inspect
    params.permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end


end
