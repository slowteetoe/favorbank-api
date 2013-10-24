require 'sinatra'
require 'json'

get '/' do
  {"app" => "favorbank", "version" => 0.02 }.to_json
end
