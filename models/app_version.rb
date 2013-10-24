class AppVersion
  include Mongoid::Document
  field :name, type: String
  field :version, type: String
end