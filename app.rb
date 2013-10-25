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

Tire.configure do
  url ENV['ELASTICSEARCH_URL'] 
  logger 'elasticsearch.log', :level => 'debug'
end

get '/' do
  "FavorBank API #{ENV['RACK_ENV']}"
end

get '/info' do
  AppVersion.all.first.to_json
end

get '/init' do
  AppVersion.all.destroy
  AppVersion.create({:name => 'FavorBank-API', :version => 0.4})

  User.all.destroy
  Favor.all.destroy
  warner = User.create({
    :name => 'Warner Onstine', 
    :email => 'warnero@gmail.com',
    :locality => 'Las Vegas, NV 89104'
  })
  john = User.create({
    :name => 'John Smithee'
  })
  nancy = User.create({
    :name => 'Nancy Drew'
  })

  Favor.create({
      :type => "request",
      :description => "I need a ride home tomorrow afternoon from work",
      :locality => "Las Vegas 89102",
      :amount => 3,
      :user_id => warner._id
  })
  f = Favor.create({ 
      :type => "offer",
      :description => "Teach you MongoDB basics",
      :locality => "Las Vegas 89104",
      :amount => 3,
      :user_id => warner._id,
  })

  response = FavorResponse.create({
    :favor => f,
    :body => 'I would totally like to help you out with that!'
  })
  response.user = john
  response.save!
  nancy_response = FavorResponse.create({
    :favor => f,
    :body => 'I can help on tuesday with that.'
  })
  nancy_response.user = nancy
  nancy_response.save!
  
  #f.favor_responses << response
  #f.favor_responses << nancy_response
  f.save!
  response.save!
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
  u = User.includes(:favors, :debit_transactions, :credit_transactions).find_by(_id: id)
  u.to_json(include: ["favors", "credit_transactions", "debit_transactions"])
end

get '/users/:id/transactions' do

end

get '/users/:id/favors' do
  id = params[:id]
  Favor.where("user_id" => id).to_json
end

get '/search' do
  q = params[:q]
  r = Favor.tire.search( load: true ) do
    query { string "#{q}*", default_operator: "OR" }
  end

  result = []
  r.each do |f|
    this_favor = Favor.includes("user").find(f.id)
    result << JSON.parse(this_favor.to_json(include: ["user", "favor_responses"]))
  end
  result.to_json
end

get '/favors/:id' do
  id = params[:id]
  Favor.includes(:user).where(_id: id).to_json(include: ["user"])
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

