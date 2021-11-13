require 'sec_configs'

class UserAuthenticator
	class AuthenticationError < StandardError; end	#Define o erro de autenticação

	attr_reader :user   #cria função para leitura de user

	def initialize(code)
		@code =code

	end
	def perform

    	#client = Octokit::Client.new(access_token: SecConfigs.data[:github_token])

        
		if token.try(:error).present?
			raise AuthenticationError
		else
			prepare_user
			#user_client = Octokit::Client.new(
			#	acess_token: token)
		    #user_data = user_client.user.to_h.slice(:login, :avatar_url, :url, :name)

		  #   @user = 
			 #    if User.exists?(login: user_data[:login])
			 #    	User.find_by(login: user_data[:login])
			 #    else
			 #    	User.create(user_data.merge(provider: 'github'))
				# end
		end
	end
	def client
		@client ||= Octokit::Client.new(access_token: SecConfigs.data[:github_token])
		#só grava o valor se a variável é nova

	end
	def token
		@token = client.exchange_code_for_token(code,SecConfigs.data[:oauth_app_client_id],SecConfigs.data[:oauth_app_client_secret])
	end
	def user_data
			#user_client = Octokit::Client.new(
			#	acess_token: token)
		    #user_data = user_client.user.to_h.slice(:login, :avatar_url, :url, :name)
		    @user_data = Octokit::Client.new(acess_token: token
		    	).user.to_h.slice(:login, :avatar_url, :url, :name)

	end
	def prepare_user
			#Sim, eu posso fazer isso:
			#note também que as antigas variáveis user_data,token e client são automaticamente
			#substituídas pelas funções correspondentes
		    @user = 
			    if User.exists?(login: user_data[:login])
			    	User.find_by(login: user_data[:login])
			    else
			    	User.create(user_data.merge(provider: 'github'))
				end
	end

	private
	attr_reader :code
end