json.array!(@categories) do |category|
  json.extract! category, :id, :parent_id, :name, :meta_keywords, :meta_description, :slug
  json.url show_id_categories_path(category, format: :json)
end
