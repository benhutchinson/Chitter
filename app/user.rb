require_relative 'post'

class User

  include DataMapper::Resource

  property :id,   Serial
  property :name, String
  property :email, String
  property :username, String
  property :password, String

  has n, :posts

end