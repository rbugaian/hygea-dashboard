module WardsHelper
	def parse_patients_param(params)
		patients_root = params[:patients]
		if patients_root
			ids = patients_root[:id]

			if ids
	    		ids.shift
	    		patients = Patient.find(ids)
	    	end
	    end
	end
end
