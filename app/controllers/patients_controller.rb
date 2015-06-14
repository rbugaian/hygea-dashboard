class PatientsController < ApplicationController
  
  def submit
    patient = current_doctor.patients.build(patient_params)
    
    logger.debug "Patients PARAMS: " + patient.inspect.to_s
    
    if patient.save
      redirect_to :controller => 'dashboard', :action => 'patients_section'
    else
      render json: { errors: task.errors }, status: 422
    end
  end
  
  def show_patient
    patient_id = params[:id]
    
    @patient = Patient.find_by(id: patient_id)

    @personnel_name = Doctor.find(@patient.personnel_id) 
    
    @patient_name = @patient.last_name.to_s + ' ' + @patient.first_name.to_s
  end
    
  
  private 
  
  def patient_params
    params.permit(:last_name, :first_name, :idno, :personnel_id, :blood_type, :ward_id)
  end
end
