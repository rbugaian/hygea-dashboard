module SessionContainer

	@@auth_token = ''

	def self.store(auth_token)
		@@auth_token = auth_token
    session[:hygea_key] = @auth_token
	end

	def self.restore
		@@auth_token = session[:hugea_key]
	end

	# def stored_auth_token
	# 	logger.debug "AUTH: " + @auth_token
	# 	@auth_token
	# end

	# def store_auth_token(auth_token)
	# 	logger.debug 'Storing TOKEN: ' + auth_token
	# 	@auth_token = auth_token
	# end
end