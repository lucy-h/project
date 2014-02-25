json.array!(@items) do |item|
  json.extract! item, :id, :name, :url, :price
  json.url item_url(item, format: :json)
end
