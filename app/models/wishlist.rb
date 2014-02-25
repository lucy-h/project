class Wishlist
  include Mongoid::Document

  belongs_to :user
  belongs_to :store
  has_many :items

  field :want_by, type: Date
  field :total_cost, type: Float
end
