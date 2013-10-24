class FavorTransaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :accepted, type: Boolean
  field :amount, type: Number
  belongs_to :debit_user, :class_name => 'User', :inverse_of => :debit_transactions
  belongs_to :credit_user, :class_name => 'User', :inverse_of => :credit_transactions
  belongs_to :favor
end