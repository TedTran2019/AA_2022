# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token

  def self.generate_session_token
    session_token = SecureRandom.urlsafe_base64(16)
    while User.exists?(session_token:)
      session_token = SecureRandom.urlsafe_base64(16)
    end
    session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username:)
    return nil unless user&.is_password?(password)

    user
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private 

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
