class Wishlist
  include Mongoid::Document

  belongs_to :user
  belongs_to :store
  has_many :items, as: :container

  field :want_by, type: Date
  field :total_cost, type: Float

  validates :user, :presence => true
  validates :store, :presence => true
  validates_associated :user
  validates_associated :store
  validates :items, :length => { :minimum => 1 }
end
