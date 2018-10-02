class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to '/exercises'
    end
  end

   get '/show' do
     @user = current_user
     erb :'/users/show'
   end

  post '/signup' do
    if params[:user].empty?
      redirect to '/signup'
    else
      @user = User.new(params[:user])
      @user.save
        session[:user_id] = @user.id

        redirect to '/exercises'
      end
    end

    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/exercises'
    end
  end

  post '/login' do
    user = User.find_by(params[:username])
    if user
      # && user.authenticate(params[:password])
      redirect to :'/exercises'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/login'
    end
  end
end
