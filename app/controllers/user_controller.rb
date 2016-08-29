require 'pry'
class UserController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/#{current_user.slug}"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/#{user.slug}"
    else
      redirect to "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect to "/#{current_user.slug}"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    user = User.create(params)
    session[:user_id] = user.id
    if user.save
      redirect to "/#{user.slug}"
    else
      redirect to "/signup"
    end
  end

  get '/logoff' do
    session.clear
    redirect to "/login"
  end

  get "/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    @total_calories = total_calories_in_a_day(@user, Time.now)
    @breakfast_meals = meals_in_a_day(@user, Time.now, "Breakfast")
    @lunch_meals = meals_in_a_day(@user, Time.now, "Lunch")
    @dinner_meals = meals_in_a_day(@user, Time.now, "Dinner")
    @snack_meals = meals_in_a_day(@user, Time.now, "Snack")
    erb :"/users/show"
  end

  get "/days/:id/:slug" do
    redirect_if_not_logged_in
    @day = Day.find(params[:id])
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    @total_calories = total_calories_in_a_day(@user, @day.date)
    @breakfast_meals = meals_in_a_day(@user, @day.date, "Breakfast")
    @lunch_meals = meals_in_a_day(@user, @day.date, "Lunch")
    @dinner_meals = meals_in_a_day(@user, @day.date, "Dinner")
    @snack_meals = meals_in_a_day(@user, @day.date, "Snack")
    erb :"/users/show"
  end

end
