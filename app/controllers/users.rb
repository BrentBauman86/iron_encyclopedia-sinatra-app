class UsersController < ApplicationController

  get '/users/show' do
    if logged_in?
      @user = current_user
      erb :'/users/show'
    else
      erb :'/login'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to '/exercises'
    end
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
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to :'/exercises'
    else
      flash[:message] = "*Incorrect username or password, please try again*"
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      erb :'/welcome'
    else
      redirect to '/login'
    end
  end
end
