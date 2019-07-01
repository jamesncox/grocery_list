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
                @item = Item.new(produce: params[:produce], meat: params[:meat], fish: params[:fish], grains: params[:grains], dairy: params[:dairy], snacks: params[:snacks], spices: params[:spices], staples: params[:stapes], frozen: params[:frozen])
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
                if params[:produce] != "" 
                    @team_stat.update(produce: params[:produce], meat: params[:meat], fish: params[:fish], grains: params[:grains], dairy: params[:dairy], snacks: params[:snacks], spices: params[:spices], staples: params[:stapes], frozen: params[:frozen])
                    erb :"team_stats/show_team_stats" 
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