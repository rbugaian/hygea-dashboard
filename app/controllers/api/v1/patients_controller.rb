class Api::V1::PatientsController < ApplicationController
	before_action :authenticate_doctor_with_token!, only: [:update, :destroy]
  	respond_to :json

  	def list

		if current_doctor
			logger.debug "DOCTOR ID: " + current_doctor.id.to_s

			patient_list = current_doctor.patients

			if patient_list
				#render json: patient_list.as_json(:only => [:id, :first_name, :last_name]), status: 201
				render json: patient_list, status: 201
			end
		else
			render json: { errors: 'Wrong auth token' }, status: :unauthorized
		end
  	end

	def submit
		patient = current_doctor.patients.build(patient_params)

		logger.debug "Patients PARAMS: " + patient.inspect.to_s

		if patient.save
		  render json: patient.as_json
		else
		  render json: { errors: task.errors }, status: 422
		end
	end

	def show
		patient_id = patient_params[:id]

		patient = current_doctor.patients.find_by(id: patient_id)

		if patient 
			#render json: patient.as_json(:only => [:id, :first_name, :last_name, :doctor_id, :personnel_id, :ward_id, :blood_type, :ward])
			render json: patient, status: 201
		else
			render json: { errors: 'No patient with such id' }, status: 404
		end
	end


	private 

	def patient_params
		params.permit(:id, :last_name, :first_name, :idno, :personnel_id, :blood_type, :ward_id)
	end
end
