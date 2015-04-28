class Api::V1::ProfileController < ApplicationController
	before_action :authenticate_doctor_with_token!, only: [:update, :show]
	respond_to :json

	def show
		if current_doctor
			render json: current_doctor.as_json(:only => [ :id, :first_name, :last_name ]), status: 201
		else
			render json: { errors: 'Wrong auth token' }, status: :unauthorized
		end
	end

	def submit
	    doctor = current_doctor

	    if doctor
	    	if doctor.update(profile_params)
	    		render json: doctor.as_json(:only => [ :id, :first_name, :last_name ]), status: 201
	    	else
	    		render json: { errors: 'Update failed' }, status: 400
	   		end
	    else
			render json: { errors: 'Wrong auth token' }, status: :unauthorized
	    end
  	end
  
	private 

	def profile_params
		params.permit(:id, :first_name, :last_name)
	end
end