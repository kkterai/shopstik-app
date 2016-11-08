class ItemsController < ApplicationController

  get '/new' do
    erb :'items/new'
  end

  post '/items' do
      if params["item"] != ""
        @item = current_user.items.create(item: params[:item])
        redirect '/list'
      else
        redirect '/new'
      end
  end

  get '/items/:id' do
    @item = current_user.items.find(params[:id])
    redirect '/list'
  end

  get '/items/:id/edit' do
    @item= Item.find(params[:id])
    if current_user.items.include?(@item)
      erb :'/items/edit'
    else
      redirect "/list"
    end
  end

  patch "/items/:id" do
    @item = current_user.items.find(params[:id])
    if params[:item] != ""
      @item.update(item: params[:item])
      redirect "/items/#{@item.id}"
    else
      redirect "/items/#{@item.id}/edit"
    end
  end

  delete '/items/:id/delete' do
    @item = Item.find(params[:id])
    if current_user.items.include?(@item)
      @item.delete
      redirect '/list'
    else
      redirect '/list'
    end
  end
end
