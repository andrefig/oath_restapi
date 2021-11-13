class AccessToken < ApplicationRecord
 belongs_to :user
  after_initialize :generate_token

  private

  def generate_token
    #gera token aleatório de acesso (entre o API nosso e o Usuário, diferente do token entre nosso API e o GitHub)
    loop do
      break if token.present? && !AccessToken.exists?(token: token)
      self.token = SecureRandom.hex(10)
    end
  end
end