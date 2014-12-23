require 'bcrypt'
require_relative 'post'

class User

  include DataMapper::Resource
  
  property :id,       Serial
  property :name,     String
  property :email,    String, :unique => true, :format => :email_address
  property :username, String, :unique => true
  property :password_hash, Text
  property :password_token, Text

  has n, :posts

  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user = first(:username => username)
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end

def self.validate_unique_email_user?(params)
  User.all.map {|user| user.email }.include?(params[:email]) && User.all.map {|user| user.username }.include?(params[:username])
end

end