require 'sinatra'
require 'json'
require 'mongoid'
require './models/app_version'

Mongoid.load!("config/mongoid.yml")

get '/' do
  AppVersion.all.first.to_json
end

get '/init' do
  AppVersion.all.destroy
  AppVersion.create({:name => 'FavorBank-API', :version => 0.3})
end