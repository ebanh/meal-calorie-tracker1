class MealController < ApplicationController

  get '/meals/new' do
    erb :"/meals/new"
  end

end
