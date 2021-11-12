require 'rails_helper'
#require 'factories/users'

describe UserAuthenticator do 
	describe '#perform' do 



	context 'when the code is incorrect' do #context 
		let(:error){
				double("Sawyer::Resource", error: "bad_verification_code") } #Override do método para permitir teste offline
		before do 
				allow_any_instance_of(Octokit::Client).to receive(
					:create_authorization).and_return(error) #Override do método para permitir teste offline
		end
		it 'should raise an error' do 
				authenticator = described_class.new('sample_code')
				expect{authenticator.perform}.to raise_error(UserAuthenticator::AuthenticationError)
				expect(authenticator.user).to be_nil
		end
	end
    context 'when code is correct' do
      let(:user_data) do
        {
          login: 'jsmith1',
          url: 'http://example.com',
          avatar_url: 'http://example/avatar',
          name: 'John Smith'
        }
      end
 
      before do
        allow_any_instance_of(Octokit::Client).to receive(
          :exchange_code_for_token
        ).and_return('validaccesstoken')
 
        allow_any_instance_of(Octokit::Client).to receive(
          :user
        ).and_return(user_data)
      end
 
      it('should save the user when the user does not exists') do
      	authenticator = described_class.new('sample_code')
        # expect(authenticator.perform).to change{User.count}.by(1)
        expect {authenticator.perform}.to change { User.count }.by(1)
        #pp User.last
        expect(User.last.name).to eq('John Smith')
      end
    end
  end
end