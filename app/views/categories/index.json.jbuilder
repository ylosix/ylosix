json.array!(@categories) do |category|
  json.extract! category, :id, :parent_id, :name, :meta_keywords, :meta_description, :slug
  json.url category_path(category, format: :json)
end
