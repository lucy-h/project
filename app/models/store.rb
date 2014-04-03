class Store
  include Mongoid::Document

  has_many :items, as: :container

  field :name, type: String
  field :url, type: String
  field :shipping_min, type: Float

  validates :url, :presence => true
  validates :name, :presence => true
end
