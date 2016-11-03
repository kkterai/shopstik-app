#require 'rack-flash'

class UsersController < ApplicationController
  #use Rack::Flash

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
      redirect "/list"
    else
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
        redirect "/list"
    elsif !logged_in?
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
