class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
          erb :"users/signup"
        else 
          redirect to '/items' 
        end 
      end 
    
      post '/signup' do
       if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          redirect to '/items'
        end 
      end
      
      get '/login' do
        if !logged_in?
          erb :'users/login'
        else
          redirect to '/items'
        end
      end 
      
      post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id 
          redirect to '/items'
        else 
          erb :index
        end 
      end
      
      get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
      end 
    
      get '/logout' do
        if logged_in?
          session.destroy
          erb :index
        else 
          erb :index
        end 
      end 

end 
