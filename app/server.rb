require 'sinatra/base'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require_relative './post.rb'
require_relative './user.rb'

DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base
  
  set :views, Proc.new { File.join(root, "./views") }
  set :public_folder, Proc.new { File.join(root, ".././public") }

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
    # flash[:notice] = "You have successfully registered."
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
