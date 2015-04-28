class PersonnelController < ApplicationController
  
  def submit
    personnel = Personnel.create(personnel_params)
    
    logger.debug "Personnel PARAMS: " + personnel.inspect.to_s
    
    if personnel.save
      redirect_to :controller => 'dashboard', :action => 'personnel_section'
    else
      render json: { errors: personnel.errors }, status: 422
    end
  end
  
  def show_personnel
    personnel_id = params[:id]
    
    @personnel = Personnel.find_by(id: personnel_id)
    
  end
    
  
  private 
  
  def personnel_params
    params.permit(:last_name, :first_name, :email, :password)
  end
  
end
