json.array!(@categories) do |category|
  json.extract! category, :id, :parent_id, :name, :slug
  json.url show_id_categories_path(category, format: :json)
end
