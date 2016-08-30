require './config/environment'
require 'rack-flash'
require 'pry'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "pizzaisgoodforyou"
  end

  get '/' do
    if logged_in?
      redirect to "/#{current_user.slug}"
    else
      redirect to "/login"
    end
  end

  helpers do

     def logged_in?
       !!session[:user_id]
     end

     def current_user
       User.find(session[:user_id])
     end

     def redirect_if_not_logged_in
       if !logged_in?
         flash[:message] = "You need to be logged in to do that."
         redirect "/login"
       end
     end

     def redirect_if_incorrect_user(user)
       if user != current_user
         flash[:message] = "You are not allowed to access another user's account."
         redirect to "/#{current_user.slug}"
       end
     end

     def meals_in_a_day(user, date_requested, meal_time_requested)
       days_returned = []
       user.days.collect do |day|
         if day.date.strftime("%m%d%y") == date_requested.strftime("%m%d%y") && day.meal_time == meal_time_requested
           days_returned << day
         end
       end
       meals_returned(days_returned)
     end

     def meals_returned(days)
       days.collect { |day| day.meals }.flatten
     end

     def total_calories_in_a_day(user, date)
       total_calories = 0
       user.days.each do |day|
         if day.date.strftime("%m%d%y") == date.strftime("%m%d%y")
            day.meals.each do |meal|
              total_calories += meal.calories
            end
         end
       end
       total_calories
     end


  end
end
