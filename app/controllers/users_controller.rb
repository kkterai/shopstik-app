require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash


  get '/signup' do
    if logged_in?
      redirect '/list'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id

        flash[:message] = "Welcome #{user.username}!"

        redirect "/list"
    elsif !logged_in?

        flash[:message] = "Your username, email, or password is missing. Please try again."

        redirect '/signup'
    end
  end

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
      @user = current_user

      flash[:message] = "Welcome Back, #{@user.username}!"

      redirect "/list"
    else

      flash[:message] = "The username and password is incorrect. Please try again."

      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/list' do
    @items = current_user.items
    erb :'users/list'
  end
end
