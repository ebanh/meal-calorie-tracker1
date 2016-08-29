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
    current_user.days.create(params)

    redirect to "/#{current_user.slug}"
  end

end
