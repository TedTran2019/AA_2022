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
  include Commentable
  
  attr_reader :password

  after_initialize :ensure_session_token
  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password_digest can't be blank" }
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :goals,
  dependent: :destroy

  has_many :authored_comments, 
  class_name: :Comment,
  foreign_key: :author_id

  # has_many :comments, as: :commentable,
  # dependent: :destroy
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user&.is_password?(password)
    
    user
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
