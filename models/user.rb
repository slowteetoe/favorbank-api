class User
  include Mongoid::Document

  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name "users-#{ENV['RACK_ENV'] || "unknown"}"

  mapping do
    indexes :name, :analyzer => 'snowball', :boost => 100
  end

  field :name, type: String
  field :email, type: String
  field :bio, type: String
  field :avatar, type: String
  field :locality, type: String
  field :token, type: String 
  has_many :favor_responses
  has_many :favors
  has_many :debit_transactions, :class_name => 'FavorTransaction', :inverse_of => :debit_user
  has_many :credit_transactions, :class_name => 'FavorTransaction', :inverse_of => :credit_user
end