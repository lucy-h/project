json.array!(@stores) do |store|
  json.extract! store, :id, :name, :url, :shipping_min
  json.url store_url(store, format: :json)
end
