# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true

  before_validation :check_token

  def self.new_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = self.find_by_email(email)
    (user && user.is_password?(password)) ? user : nil
  end

  def password=(password_string)
    self.password_digest = BCrypt::Password.create(password_string).to_s
  end

  def is_password?(password_string)
    BCrypt::Password.new(self.password_digest).is_password?(password_string)
  end

  def reset_session_token!
    self.session_token = self.class.new_session_token
    self.save!
    self.session_token
  end

  private

  def check_token
    self.session_token ||= self.class.new_session_token
  end
end
