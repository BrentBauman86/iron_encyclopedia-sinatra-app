class ExercisesController < ApplicationController

  get '/exercises' do
    @exercises = Exercise.all
    erb :'exercises/index'
  end

  get '/exercises/new' do
    # @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

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
        flash[:message] = "New Exercise Created"
        redirect "/exercises"
      else
        flash[:message] = "Error Creating Course"
        redirect "/exercises"
      end
  end

  get "/exercises/:id/edit" do
    @exercises = Exercise.find_by(id: params[:id])

    if current_user == @exercises
      erb :'/exercises/edit'
    else
      redirect to '/exercises'
  end
end

  # patch "/exercises/:id" do
  #   @exercises = Exercise.find_by(id: params[:id])
  #   if current_user != @exercises.user_id
  #
  #   if @exercises.update(name: params[:name], muscle_group: params[:muscle_group], rep_range: params[:rep_range])
  #     flash[:message] = "Exercise was successfully updated"
  #     redirect to "/exercises/#{@exercises.id}"
  #   else
  #     erb :"/exercises/edit"
  #   end
  # end
end
end
