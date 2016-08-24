class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'apps/views'
    enable :sessions
    set :session_secret, "pizzahasnocalories"
  end


end
