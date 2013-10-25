require 'sinatra'
require 'json'
require 'mongoid'
require 'tire'
require 'yajl/json_gem'
require './models/app_version'
require './models/user'
require './models/favor'
require './models/favor_response'
require './models/favor_transaction'

Mongoid.load!("config/mongoid.yml")

get '/' do
  "FavorBank API #{ENV['RACK_ENV']}"
end

get '/info' do
  AppVersion.all.first.to_json
end

get '/init' do
  AppVersion.all.destroy
  AppVersion.create({:name => 'FavorBank-API', :version => 0.3})
end

get '/users' do
  User.all.to_json
end

post '/users' do
  User.create({
    :name => params[:name]
  })
end

put '/users' do

end

get '/users/:id' do

end

get '/users/:id/transactions' do

end

get '/users/:id/favors' do

end

get '/search' do

end

get '/favors/:id' do

end

post '/favors' do

end 

put '/favors/:id' do

end

get '/favors/:id/responses' do

end
     
post 'favors/:id/responses' do

end          

