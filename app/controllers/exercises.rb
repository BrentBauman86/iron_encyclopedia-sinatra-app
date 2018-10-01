class ExercisesController < ApplicationController

  get '/exercises' do
    @exercises = Exercise.all
    erb :'exercises/index'
  end


  get "/exercises/:id/edit" do
    @exercises = Exercise.find(params[:id])
    erb :'exercises/edit'
  end

  post "/exercises/:id" do
    redirect_if_not_logged_in
    @exercises = Exercise.find(:id => params[:id])
    unless Exercise.valid_params?(params)
      redirect "/exercises/#{@exercises.id}"
    end
    @exercises.update(params[:exercise_id])
    redirect "/exercises/#{@exercises.id}"
  end
end
