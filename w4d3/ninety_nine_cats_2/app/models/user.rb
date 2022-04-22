class User < ApplicationRecord
  attr_reader :password

  after_initialize :ensure_session_token
  validates :user_name, :session_token, presence: true
  validates :password_digest, presence: { message: 'Must have a password!' }
  validates :password, length: { minimum: 6, allow_nil: true }

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil unless user&.is_password?(password)

    user
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  has_many :cat_rental_requests
end