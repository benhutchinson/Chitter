require_relative 'user'

class Post

  include DataMapper::Resource

  property :id,       Serial
  property :message,  Text, :length => 1..140,
  property :time,     DateTime

  belongs_to :user

end