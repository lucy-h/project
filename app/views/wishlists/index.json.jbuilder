json.array!(@wishlists) do |wishlist|
  json.extract! wishlist, :id, :want_by, :total_cost
  json.url wishlist_url(wishlist, format: :json)
end
