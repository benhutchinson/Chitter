require_relative 'user'

class Post

  include DataMapper::Resource

  property :id,       Serial
  property :message,  Text
  property :time,     DateTime

  belongs_to :user

end