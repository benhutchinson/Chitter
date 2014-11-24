require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require_relative './post.rb'
require_relative './user.rb'

DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base
  
  set :views, Proc.new { File.join(root, "./views") }
  set :public_folder, Proc.new { File.join(root, ".././public") }
  enable :sessions
  set :session_secret, 'super secret'

  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    @posts = Post.all
    erb :index
  end

  get '/user_reg' do 
    erb :sign_up
  end

  post '/user_reg' do 
    reg_user = User.create(:name => params[:name],
                          :email => params[:email],
                          :username => params[:username],
                          :password => params[:password])
    if reg_user.save
      flash[:notice] = "You have successfully registered.  Welcome to the party."
      redirect '/'
    else 
      if User.all.map {|user| user.username }.include? (params[:username])
        flash[:error] = "Sorry. That username has already been taken.  Please choose another one."
      elsif User.all.map {|user| user.email }.include? (params[:email])
        flash[:error] = "Sorry. That email address has already been used.  Please use another one."
      else
        flash[:error] = "Please try again."
      end
      erb :sign_up
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
