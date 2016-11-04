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

  get '/items/:id' do
    @item= Item.find(params[:id])
    erb :'items/show'
  end

  get '/items/:id/edit' do
    @item= Item.find(params[:id])
    if current_user.items.include?(@item)
      erb :'/items/edit'
    else
      redirect "/list"
    end
  end

  patch '/list' do
    if params["item"] == ""
      @item = Item.find(params[:id])
      redirect "/items/#{@item.id}/edit"
    else
      @item = Item.find(params[:id])
      @item.update(:item => params["item"])
      @item.save
      redirect "/list"
    end
  end
end
