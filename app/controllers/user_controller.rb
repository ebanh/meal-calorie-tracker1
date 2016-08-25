require 'pry'
class UserController < ApplicationController

  get "/users/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/users/show"
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/users/#{current_user.slug}"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/users/#{user.slug}"
    else
      redirect to "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect to "/users/#{current_user.slug}"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    user = User.create(params)
    session[:user_id] = user.id
    if user.save
      redirect to "/users/#{user.slug}"
    else
      redirect to "/signup"
    end
  end

  get '/logoff' do
    session.clear
    redirect to "/login"
  end

end
