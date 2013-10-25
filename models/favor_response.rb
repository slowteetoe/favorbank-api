class FavorResponse
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :accepted, type: Boolean
  belongs_to :user
  embedded_in :favor
end