class Api::V1::PersonnelController < ApplicationController
	before_action :authenticate_personnel_with_token!, only: [:update, :destroy]
	respond_to :json

	def show
		respond_with Personnel.find(params[:id])
	end

	def create
		personnel = Personnel.create(personnel_params)

		logger.debug 'Personnel params: ' + personnel_params.inspect

		if (personnel.save)
			render json: personnel, status: 201, location: [:api, personnel]
		else
			render json: { errors: personnel.errors }, status: 422
		end
	end

	def update
		personnel = current_personnel

		if personnel.update(personnel_params)
			render json: personnel, status: 200, location: [:api, personnel]
		else
			render json: { errors: personnel.errors }, status: 422
		end
	end

	def destroy
		current_personnel.destroy
		head 204
	end

	private 

	def personnel_params
		logger.debug 'Provided personnel params: ' + params.inspect

		params.permit(:email, :password, :password_confirmation)
	end

end
