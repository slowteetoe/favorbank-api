require 'sinatra'
require 'json'
require 'mongoid'

Mongoid.load!("config/mongoid.yml")

class AppVersion
  include Mongoid::Document
  field :name, type: String
  field :version, type: String
end

get '/' do
  AppVersion.all.first.to_json
end

get '/init' do
  AppVersion.all.destroy
  AppVersion.create({:name => 'FavorBank-API', :version => 0.3})
end