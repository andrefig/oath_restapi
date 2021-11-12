require 'rails_helper'
require 'factories/users'

RSpec.describe User, type: :model do
  describe '#validations' do
    it 'should validate presence of atributes' do
      user = build :user
      expect(user).to be_valid
      user = build :user, login: nil, provider: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:login]).to include("can't be blank")
      expect(user.errors.messages[:provider]).to include("can't be blank") 
    end
  end
end
