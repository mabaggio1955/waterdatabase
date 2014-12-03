json.array!(@contents) do |content|
  json.extract! content, :id, :title, :description, :locale
  json.url content_url(content, format: :json)
end
