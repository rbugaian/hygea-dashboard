class DashboardController < ApplicationController
	before_action :authenticate_doctor_with_token!
	
	def show 

	end

	def exit
		current_doctor.generate_auth_token!
		current_doctor.save
		redirect_to '/sign_in'
	end

	

end
