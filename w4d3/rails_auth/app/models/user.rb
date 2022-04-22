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

  before_validation :ensure_session_token

  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank!"}
  validates :password, length: { minimum: 6, allow_nil: true }


  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user&.is_password?(password)

    user
  end
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
