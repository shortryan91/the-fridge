
require 'sinatra'
require 'sinatra/reloader'
# require 'pry'

require_relative 'db_config'
require_relative 'models/ingredient'
require_relative 'models/user'
require_relative 'models/recipe'


enable :sessions

helpers do
  def  logged_in?
    current_user != nil ? true : false
  end
  def current_user
    User.find_by(id: session[:user_id])
  end

end

get '/' do
  erb :index
end

get '/sign_in' do
  erb :sign_in
end

post '/sessions' do
   user = User.find_by(email: params[:email])
   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect '/ingredients'
   else
     erb :sign_in
   end
end

post '/sign_in' do
  user = User.new(name: params[:name], email: params[:email], password: params[:password])
  user.save
  redirect '/ingredients'
end

get '/sign_up' do
  erb :sign_up

end

post '/signup' do
  user = User.new
  user.email = params[:email]
  user.password = params[:password]
  user.save
  redirect '/ingredients'
end

delete '/session' do
  session[:user_id] = nil
  redirect '/sign_in'
end


get '/ingredients' do
  @food = Ingredient.all
  erb :ingredient_display
end

post '/ingredients' do
  ingredients = Ingredient.new
  ingredients.name = params[:name]
  ingredients.save

  redirect '/ingredients'
end

get '/ingredients/new' do
  erb :new
end

delete '/ingredients/:id' do
  ingredients = Ingredient.find(params[:id])
  ingredients.destroy

  redirect '/ingredients'
end

get '/results' do

  @recipes = Recipe.where("ingredient @> ARRAY[?]::text[]",params[:ingredients])
  erb :recipe_results
end

get '/contact' do
  erb :contact
end
