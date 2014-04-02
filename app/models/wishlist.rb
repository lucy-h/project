class Wishlist
  include Mongoid::Document
  before_save :calculate_total

  belongs_to :user
  belongs_to :store
  has_many :items, as: :container

  field :want_by, type: Date
  field :total_cost, type: Float, default: 0

  validates :user, :presence => true
  validates :store, :presence => true
  validates_associated :user
  validates_associated :store
  #validates :items, :length => { :minimum => 1 }

  def calculate_total
    x = 0
    self.items.each do |item|
      x = x + item.price
    end
    self.total_cost = x;
  end
end