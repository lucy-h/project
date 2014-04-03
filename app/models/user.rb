class User
  include Mongoid::Document

  has_many :wishlists

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :github_url, type: String
  field :website, type: String
  field :building, type: String
  field :role, type: String, default: 'user'
  
  validates :email, :presence => true
end
