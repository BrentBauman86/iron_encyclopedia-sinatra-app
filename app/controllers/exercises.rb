class ExercisesController < ApplicationController

  get '/exercises' do
    @exercises = Exercise.all
    erb :'exercises/index'
  end

  get '/exercises/new' do
    if !logged_in?
      redirect to '/login'
    else
      @exercise = Exercise.new
      erb :'/exercises/new'
  end
end 


  get "/exercises/:id/edit" do
    # binding.pry
    @exercises = Exercise.find_by(id: params[:id])

    if current_user == @exercises
      erb :'/exercises/edit'
    else
      redirect to '/exercises'
  end
end

  patch "/exercises/:id" do
    @exercises = Exercise.find_by(id: params[:id])
    redirect '/exercises' if current_user != @exercises.user_id

    if @exercises.update(name: params[:name], muscle_group: params[:muscle_group], rep_range: params[:rep_range])
      flash[:message] = "Exercise was successfully updated"
      redirect to "/exercises/#{@exercises.id}"
    else
      erb :"/exercises/edit"
    end
  end
end
