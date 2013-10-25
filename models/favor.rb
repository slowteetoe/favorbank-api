class Favor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, type: 'integer', index: :not_analyzed
    indexes :description, :analyzer => 'snowball', :boost => 100
    indexes :favor_responses do
      indexes :body, :analyzer => 'snowball', :boost => 10
      indexes :user do
        indexes :name, :analyzer => 'snowball'
      end
    end
    indexes :user do
      indexes :id, type: 'integer', index: :not_analyzed
      indexes :name, :analyzer => 'snowball'
    end
  end

  field :type, type: String
  field :description, type: String
  field :locality, type: String
  field :completed, type: Boolean
  field :amount, type: Integer
  embeds_many :favor_responses
  belongs_to :user

end