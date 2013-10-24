class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :description, type: String
  field :avatar, type: String
  field :locality, type: String
  field :token, type: String 
  has_many :favor_responses
  has_many :favors
  has_many :debit_transactions, :class_name => 'FavorTransaction', :inverse_of => :debit_user
  has_many :credit_transactions, :class_name => 'FavorTransaction', :inverse_of => :credit_user

end