class ExercisesController < ApplicationController

  get '/exercises' do
    @exercises = Exercise.all
    erb :'exercises/index'
  end

  get "/exercises/:id/edit" do
    @exercises = Exercise.find_by(id: params[:id])

    if current_user.id == @exercises.user_id
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
      redirect "/exercises/#{@exercises.id}"
    else
      erb :"/exercises/edit"
    end
  end
end
