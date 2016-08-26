class MealController < ApplicationController

  get '/meals/new' do
    erb :"/meals/new"
  end

  get '/meals' do
    @user = current_user
    erb :"/meals/index"
  end

  post '/meals' do
    Meal.create(params)

    redirect to '/meals'
  end

end
