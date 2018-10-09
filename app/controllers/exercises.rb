
class ExercisesController < ApplicationController
# use Rack::Flash

  get '/exercises' do
    if logged_in?
    @exercises = Exercise.all
    erb :'exercises/index'
  else
    redirect to '/login'
  end
end

  get '/exercises/new' do
    if !logged_in?
      redirect to '/login'
    else
      @exercises = Exercise.new
      erb :'/exercises/new'
  end
end

  post '/exercises' do
    if !params[:name].empty? || !params[:muscle_group].empty? || !params[:rep_range].empty? && logged_in?
      exercise = Exercise.new(params)
      exercise = current_user.exercises.build(params)
      if exercise.valid?
         exercise.save
         flash[:message] = "*New Exercise Created*"
         redirect "/exercises"
      else
        redirect "/exercises"
      end
    end
  end

  get '/exercises/:id' do
    if !logged_in?
      redirect to '/login'
    end
      @exercise = Exercise.find(params[:id])
    erb :'/exercises/show'
  end

  get '/exercises/:id/edit' do
    if !logged_in?
      redirect to '/login'
    end
    @exercise = Exercise.find(params[:id])
      if current_user.id == @exercise.user_id
      erb :'/exercises/edit'
    else
      redirect to '/exercises'
    end
  end

    patch '/exercises/:id' do
      if !logged_in?
        redirect to '/login'
      end
        @exercise = Exercise.find(params[:id])
      if @exercise.update(name: params[:name], muscle_group: params[:muscle_group], rep_range: params[:rep_range])
        flash[:message] = "*updated exercise*"
        redirect to "/exercises/#{@exercise.id}"
      else
        erb :'/exercises/edit'
      end
    end

    delete '/exercises/:id' do
      if !logged_in?
        redirect to '/login'
      end
      @exercise = Exercise.find(params[:id])
      if current_user.id == @exercise.user_id && @exercise.destroy
        flash[:message] = "*byebye exercise*"
      else
        flash[:message] = "Not your exercise to delete sucka!"
      end
        redirect to "/exercises"
      end
  end
