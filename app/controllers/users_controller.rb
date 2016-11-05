require 'rack-flash'

class UsersController < ApplicationController

  enable :sessions
  use Rack::Flash

  get '/login' do
    if logged_in?
      redirect '/list'
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      flash[:message] = "Welcome Back!"

      redirect "/list"
    else

      flash[:message] = "The username and password is incorrect. Please try again."

      redirect "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/list'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id

        flash[:message] = "Welcome to your Shopstik!"

        redirect "/list"
    elsif !logged_in?

        flash[:message] = "Your username, email, or password is missing. Please try again."

        redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/list' do
    erb :'users/list'
  end
end
