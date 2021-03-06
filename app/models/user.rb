require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :routes, foreign_key: :creator_id
  validates :email, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
  validates :password_hash, :email, presence: true 
  validates :first_name, presence: true

  def password
    @password ||= Password.new(password_hash)
  end 

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password 
  end 

  def self.authenticate(email, password)
    @user = User.find_by(email: email)
    if @user.password == password 
      return @user
    else 
      return nil 
    end 
  end 
end
