require 'bcrypt'
require_relative 'post'

class User

  include DataMapper::Resource
  
  property :id,       Serial
  property :name,     String
  property :email,    String, :unique => true, :format => :email_address
  property :username, String, :unique => true
  property :password_hash, Text

  has n, :posts

  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

end