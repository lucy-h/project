class Item
  include Mongoid::Document

  belongs_to :store

  field :name, type: String
  field :url, type: String
  field :price, type: Float
end
