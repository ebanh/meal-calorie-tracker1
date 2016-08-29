require 'pry'
class DayController < ApplicationController

  get "/days" do
    erb :"/days/index"
  end

  get "/:slug/new" do
    redirect_if_not_logged_in
    @user = current_user

    erb :"/days/new"
  end

  post "/days" do
    if (params[:meal][:name].empty? || params[:meal][:calories].empty?) && params[:day][:meal_ids].empty?
      flash[:message] = "Meal information incomplete."
      redirect to "/#{current_user.slug}/new"
    end
    day = current_user.days.create(params[:day])
    day.meals.create(params[:meal])

    redirect to "/#{current_user.slug}"
  end

end
