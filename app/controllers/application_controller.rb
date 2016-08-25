require './config/environment'
require 'rack-flash'
require 'pry'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "golfclubsaregreat"
  end

  get '/' do
    erb :index
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
  end
end
