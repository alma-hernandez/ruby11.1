class Session < ApplicationRecord
  belongs_to :user

  before_validation :generate_sessions_token

  private

  def generate_session_token
    self.token = SecureRandom.urlsafe_base64
  end
end
