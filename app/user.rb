require_relative 'post'

class User

  include DataMapper::Resource

  property :id,       Serial
  property :name,     String
  property :email,    String, :unique => true, :format => :email_address
  property :username, String, :unique => true
  property :password, String

  has n, :posts

end