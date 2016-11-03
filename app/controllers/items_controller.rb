class ItemsController < ApplicationController

  get '/new' do
    erb :'items/new'
  end

  post '/items' do
    @item = Item.new(:item => params["item"])
    @user = User.find(session[:user_id])
    if params["item"] != ""
      @user.items << Item.create(:item => params["item"])
      @user.save
      redirect '/list'
    else
      redirect '/new'
    end
  end

end
