class Favor
  include Mongoid::Document
  field :type, type: String
  embeds_many :favor_responses
  belongs_to :user
  field :description, type: String
  field :avatar, type: String
  field :locality, type: String
  field :token, type: String 
end