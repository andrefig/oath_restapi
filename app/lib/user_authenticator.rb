require 'sec_configs'

class UserAuthenticator
	class AuthenticationError < StandardError; end	#Define o erro de autenticação

	attr_reader :user   #cria função para leitura de user

	def initialize(code)
		@code =code

	end
	def perform

    	client = Octokit::Client.new(access_token: SecConfigs.data[:github_token])

        res = client.exchange_code_for_token(code,SecConfigs.data[:oauth_app_client_id],SecConfigs.data[:oauth_app_client_secret])

		if res.try(:error).present?
			raise AuthenticationError
		else
			user_client = Octokit::Client.new(
				acess_token: res)
		    user_data = user_client.user.to_h.slice(:login, :avatar_url, :url, :name)
		    User.create(user_data.merge(provider: 'github'))
		end
	end

	private
	attr_reader :code
end