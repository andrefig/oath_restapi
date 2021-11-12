class SecConfigs < ActiveRecord::Base
	def self.data
		{:github_token => "ghp_-----------------------------------", # Rails.application.credentials.dig(:github, :access_token)
	    :oauth_app_client_id =>  "----------------",
	    :oauth_app_client_secret => "--------------------------------"}

    end

end
