module Api
  module V1
    class SessionsController < ApplicationController
      respond_to :json

      def create
        logger.debug 'Sessions Params: ' + params.inspect

        doctor_password = params[:password]
        doctor_email = params[:email]
        doctor = doctor_email.present? && Doctor.find_by(email: doctor_email)

        if doctor.valid_password? doctor_password
          sign_in doctor, store: false
          doctor.generate_auth_token!
          doctor.save
          render json: doctor.as_json(:only => [:id, :auth_token ]), status: 200, location: [:api, doctor]
        else
          render json: { errors: "Invalid email or password" }, status: 422
        end
      end

      def destroy
        doctor = Doctor.find_by(auth_token: params[:id])
        doctor.generate_auth_token!
        doctor.save
        head 204
      end

    end
  end
end
