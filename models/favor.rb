class Favor
  include Mongoid::Document
  include Mongoid::Timestamps
  field :type, type: String
  field :description, type: String
  field :locality, type: String
  field :completed, type: Boolean
  field :amount, type: Integer
  embeds_many :favor_responses
  belongs_to :user
end