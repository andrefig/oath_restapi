#api_helpers.rb
module ApiHelpers
	#Extrai o dado de um json. Utilizado para o testador articles_spec.rb


	def json
		JSON.parse(response.body).deep_symbolize_keys
	end

	def json_data
		json[:data]
	end


	#OBS
	#em rails_helper.rb
	# => descomentar:
	#   Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
	# => adicionar 
	#config.include ApiHelper
end
