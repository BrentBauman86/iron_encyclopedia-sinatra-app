require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    enable :session_secret, "shushy_shush"
  end

  get "/" do
    erb :welcome
  end

end
