class UserController < ApplicationController

  get '/login' do
    if !sessions[:user_id]
      erb :"/users/login"
    else
      erb :"/users/"
    end
  end

  post '/login' do

    redirect to "/users/#{@user.id}"
  end

end
