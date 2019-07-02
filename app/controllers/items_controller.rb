class ItemsController < ApplicationController
    
    get '/items' do 
        if logged_in?
            @items = Item.all
            erb :'items/items'
        else
            redirect to '/login'
        end
    end 

    get '/items/new' do 
        if logged_in?
            erb :"items/new"
        else 
            redirect to "/login" 
        end 
    end 

    post '/items' do
        if logged_in?
            if params[:team_name] != "" 
                @item = Item.new(shopping_day: params[:shopping_day], produce: params[:produce], meat: params[:meat], fish: params[:fish], grains: params[:grains], dairy: params[:dairy], snacks: params[:snacks], spices: params[:spices], staples: params[:staples], freezer: params[:freezer])
                @item.user = current_user
                @item.save
                redirect to "/items/#{@item.id}"
            else
                redirect to '/items/new'
            end 
        else 
            redirect to '/login' 
        end
    end 

    get '/items/:id' do
        if logged_in?
            @item = Item.find_by_id(params[:id])
            erb :"items/show_items" 
        else 
            redirect to '/login'
        end
    end 

    get '/items/:id/edit' do
        if logged_in?
            @item = Item.find_by_id(params[:id])
                if @item && @item.user == current_user
                    erb :"/items/edit_items"
                else 
                    redirect to "/users/#{current_user.slug}"
                end
        else 
            redirect to "/login" 
        end 
    end 

    patch '/items/:id' do 
        if logged_in?
            @item = Item.find_by_id(params[:id])
                if params[:shopping_day] != "" 
                    @item.update(shopping_day: params[:shopping_day], produce: params[:produce], meat: params[:meat], fish: params[:fish], grains: params[:grains], dairy: params[:dairy], snacks: params[:snacks], spices: params[:spices], staples: params[:staples], freezer: params[:freezer])
                    erb :"items/show_items" 
                    redirect to "/users/#{current_user.slug}" 
                else 
                    redirect to "/users/#{current_user.slug}" 
                end 
        else 
            redirect to '/login' 
        end 
    end 

    delete '/items/:id/delete' do 
        if logged_in?
            @item = Item.find_by_id(params[:id])
                if @item && @item.user == current_user
                    @item.delete 
                    redirect to "/users/#{current_user.slug}" 
                else
                    redirect to "/items"
                end
        else 
            redirect to 'login'
        end
    end 

end 