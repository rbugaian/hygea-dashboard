class ProfileController < ApplicationController
  
  def submit
    doctor = current_doctor
    if doctor.update(profile_params)
      redirect_to :controller => 'profile', :action => 'show'
    else
    end
  end
  
  private 
  
  def profile_params
    params.permit(:id, :first_name, :last_name)
  end
end
