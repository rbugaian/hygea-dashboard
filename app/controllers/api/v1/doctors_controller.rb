class Api::V1::DoctorsController < ApplicationController
  before_action :authenticate_doctor_with_token!, only: [:update, :destroy]
  respond_to :json

  def show
    respond_with Doctor.find(params[:id])
  end

  def create
    doctor = Doctor.create(doctor_params)

    logger.debug 'Params: ' + doctor_params.inspect
    logger.debug 'Doctor Object: ' + doctor.attributes.inspect

    if doctor.save
      render json: doctor, status: 201, location: [:api, doctor]
    else
      render json: { errors: doctor.errors}, status: 422
    end
  end

  def update
    doctor = current_doctor

    # doctor = Doctor.find(params[:id])
    if user.update(doctor_params)
      render json: doctor, status: 200, location: [:api, doctor]
    else
      render json: { errors: doctor.errors }, status: 422
    end
  end

  def destroy
    # doctor = Doctor.find(params[:id])
    current_doctor.destroy
    head 204
  end

  private

  def doctor_params
    logger.debug 'Provided Params: ' + params.inspect
    # params.require(:doctor).permit(:email, :password, :password_confirmation)
    params.permit(:email, :password, :password_confirmation)

  end

end
