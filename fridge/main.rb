
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'models/add_ingredient'

def run_sql(sql)
  conn = PG.connect(dbname: 'add_ingredient')
  result =conn.exec(sql)
  conn.close
  result
end


get '/' do
  erb :index
end

get '/sign_in' do
  erb :sign_in
end

get '/ingredients' do
  erb :ingredient_display
end

post '/ingredients' do

end

get '/ingredients/new' do
  erb :new
end
