require 'pry'
class DayController < ApplicationController

  get "/:slug/meals" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)

    erb :"/days/index"
  end

  get "/:slug/new" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)

    erb :"/days/new"
  end

  get '/days/:id/edit' do
    redirect_if_not_logged_in
    @day = Day.find(params[:id])
    @user = @day.user
    redirect_if_incorrect_user(@user)
    erb :"/days/edit"
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

  patch "/days/:id" do
    day = Day.find(params[:id])
    day.update(params[:day])

    if !params[:meal][:name].empty? && !params[:meal][:calories].empty?
      day.meals.create(params[:meal])
    end

    redirect to "/#{current_user.slug}/meals"
  end

end
