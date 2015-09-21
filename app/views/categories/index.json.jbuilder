json.array!(@categories) do |category|
  json.extract! category, :id, :parent_id, :name, :slug
  json.url category_path(category, format: :json)
end
