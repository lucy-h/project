class Item
  include Mongoid::Document

  belongs_to :container, polymorphic: true

  field :name, type: String
  field :url, type: String
  field :price, type: Float

  validates :url, :presence => true
  validates :container, :presence => true
  validates_associated :container
end
