class Store
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :shipping_min, type: Float
  field :shipping_cost, type: Float
end
