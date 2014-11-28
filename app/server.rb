require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'mailgun'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://localhost/chitter_#{env}")

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
    session[:user_id] == nil ? @current_user = nil : @current_user = User.get(session[:user_id])
    @posts = Post.all
    @users = User.all
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
      flash[:notice] = "Yo #{reg_user.name}!  We really wanna see those fingers."
      session[:user_id] = reg_user.id
      redirect '/'
    else 
      if (User.all.map {|user| user.email }.include? (params[:email])) && (User.all.map {|user| user.username }.include? (params[:username]))
        flash.now[:error] = "Both that email and username have  been taken.  Please try something new."
      elsif User.all.map {|user| user.username }.include? (params[:username])
        flash.now[:error] = "Sorry. That username has already been taken.  Please choose another one."
      elsif User.all.map {|user| user.email }.include? (params[:email])
        flash.now[:error] = "Sorry. That email address has already been used.  Please use another one."
      else
        flash.now[:error] = "Please try again."
      end
      erb :sign_up
    end
  end

  get '/sign_in' do 
    erb :sign_in
  end

  post '/sign_in' do 
    username, password = params[:username], params[:password]
    user = User.authenticate(username, password)
    if user 
      session[:user_id] = user.id
      flash[:notice] = "Hi #{user.name} : Time to Chit Out"
      redirect to ('/')
    else
      flash.now[:error] = "Sorry, the email or password entered is incorrect."
      erb :sign_in
    end
  end

  get '/sign_out' do 
    unless session[:user_id] == nil
      session[:user_id] = nil
      flash[:notice] = "Signed out - don't forget to sign back in if you want to peep."
    else
      flash[:notice] = "You not signed in.  Fancy doing something about that?"      
    end
    redirect to ('/')
  end

  get '/forgot_password' do 
    erb :forgot_password
  end

  post '/forgot_password' do
    user = User.first(email: params[:email])
    if user
      user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
      user.save 
      flash[:notice] = "Thank you. Please check your email shortly."
      mg_client = Mailgun::Client.new ENV['MY_MAILGUN_KEY']
      message_params = {:from    => ENV['MY_MAILGUN_SANDBOX'],
                    :to      => params[:email],
                    :subject => 'Password Reset : Eat Peep Chit Repeat',
                    :text    => "Yo #{user.name}! Please visit https://powerful-eyrie-5942.herokuapp.com/reset_password/#{user.password_token} to reset your password.  Thank you."}
      mg_client.send_message ENV['MY_MAILGUN_SANDBOX2'], message_params
    else
      flash[:notice] = "Sorry, we can't find a user with that email.  Please register."
    end
    redirect '/'
  end

  get '/reset_password/:token' do
    @token = params[:token]
    user = User.first(password_token: @token)
    erb :reset_password
  end

  post './reset_password' do 
    flash[:notice] = "Your password has been successfully reset."
    user = User.first(password_token: params[:password_token])
    user.update(password: params[:password], password_token: nil)
    redirect '/'
  end
 
  get '/peep' do 
    if session[:user_id] == nil
      flash[:notice] = "You need to be signed in before you can post."
      redirect to ('/')
    else
      erb :peep
    end
  end

  post '/peep' do 
    Post.create(:message => params[:message],
                :user_id => session[:user_id], :time => Time.now)
    flash[:notice] = "Thanks for your wisdom.  It is now LIVE below."
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
