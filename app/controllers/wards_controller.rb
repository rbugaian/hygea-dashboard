class WardsController < ApplicationController
  
  def submit
    logger.debug "Ward PARAMS: " + ward_params.inspect.to_s
    
    ward = Ward.create(ward_params)
    
    if ward.save
      redirect_to :controller => 'dashboard', :action => 'wards_section'
    else
      render json: { errors: task.errors }, status: 422
    end
  end
  

  def add_patient
    logger.debug 'PARAMS: ' + params.inspect.to_s

    id = params[:id]

    @ward = Ward.find_by id: id

    # @all_patients = Patient.all.except(@ward.patients)

    if @ward
      logger.debug 'SELECTED WARD: ' + @ward.inspect.to_s
    end
  end

  def confirm

    logger.debug 'CONFIRM PARAMS: ' + params.inspect.to_s

    ids = params[:patients];

    ward_id = params[:ward_id]

    patients = Patient.find(ids)

    patients.each do |patient|
      patient.ward_id = ward_id

      update_data = Hash.new 
      update_data[:ward_id] = ward_id
      update_data[:id] = patient.id

      patient.update(update_data) 
    end

    redirect_to :controller => 'dashboard', :action => 'wards_section'

  end

  private
  
  def ward_params
    params.permit(:room_number, :capacity, :patients)
  end


end
