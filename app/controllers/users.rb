class UsersController < ApplicationController

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
  end
