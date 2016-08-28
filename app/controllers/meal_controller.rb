class MealController < ApplicationController

  get '/meals/new' do
    redirect_if_not_logged_in
    erb :"/meals/new"
  end

  get '/meals/:id/edit' do
    redirect_if_not_logged_in
    @meal = Meal.find(params[:id])
    redirect_if_incorrect_user(@meal.user)
    erb :"/meals/edit"
  end

  get '/meals' do
    redirect_if_not_logged_in
    @user = current_user
    erb :"/meals/index"
  end

  post '/meals' do
    Meal.create(params)
    redirect to '/meals'
  end

  patch '/meals/:id' do
    meal = Meal.find(params[:id])
    if params[:name].empty? && params[:calories].empty?
      flash[:message] = "No data entered to edit"
      redirect to "/meals/#{meal.id}/edit"
    end
    meal.name = params[:name] unless params[:name].empty?
    meal.calories = params[:calories] unless params[:calories].empty?
    meal.save

    redirect to "/meals"
  end

end
