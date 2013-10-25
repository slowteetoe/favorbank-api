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

Mongoid.logger = Logger.new($stdout)
Moped.logger = Logger.new($stdout)

Mongoid.logger.level = Logger::DEBUG
Moped.logger.level = Logger::DEBUG  
Mongoid.load!("config/mongoid.yml")

ENV['ELASTICSEARCH_URL'] = ENV['SEARCHBOX_URL'] || "http://localhost:9200"

get '/' do
  "FavorBank API #{ENV['RACK_ENV']}"
end

get '/info' do
  AppVersion.all.first.to_json
end

get '/init' do
  AppVersion.all.destroy
  AppVersion.create({:name => 'FavorBank-API', :version => 0.3})

  User.all.destroy
  Favor.all.destroy
  warner = User.create({
    :name => 'Warner Onstine', 
    :email => 'warnero@gmail.com',
    :locality => 'Las Vegas, NV 89104'
  })
  batch = [
    {
      :type => "request",
      :description => "I need a ride home tomorrow afternoon from work",
      :locality => "Las Vegas 89102",
      :amount => 3,
      :user_id => warner._id
    }, 
    {
      :type => "offer",
      :description => "Teach you MongoDB basics",
      :locality => "Las Vegas 89104",
      :amount => 3,
      :user_id => warner._id
    }]  
  Favor.collection.insert(batch)
  "ok"
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
  id = params[:id]
  User.find_by(_id: id).to_json
end

get '/users/:id/transactions' do

end

get '/users/:id/favors' do
  id = params[:id]
  Favor.where("user_id" => id).to_json
end

get '/search' do

end

get '/favors/:id' do
  id = params[:id]
  Favor.where(_id: id).to_json
end

post '/favors' do
  Flavor.create({
    :type => params[:type],
    :description => params[:description],
    :locality => params[:locality],
    :user_id => params[:user_id]
  })
end 

put '/favors/:id' do

end

get '/favors/:id/responses' do

end
     
post 'favors/:id/responses' do

end          

