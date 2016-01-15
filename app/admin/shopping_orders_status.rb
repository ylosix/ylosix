ActiveAdmin.register ShoppingOrdersStatus do
  menu parent: 'Orders', if: proc { commerce && commerce.enable_commerce_options }

  permit_params do
    permitted = [:color, :enable_invoice]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {name_translations: locales}
    permitted
  end

  index do
    selectable_column
    id_column
    column (:name) { |status| span status.name, class: 'status_tag', style: "background-color: #{status.color}" }
    column :enable_invoice
    actions
  end

  show title: proc { |p| "#{p.name}" } do
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :name
      row :enable_invoice
    end
  end

  filter :by_name_in,
         label: proc { I18n.t 'activerecord.attributes.tags_group.name' },
         as: :string
  filter :enable_invoice

  form do |f|
    f.inputs 'Shopping orders status Details' do
      f.input :color
      f.input :enable_invoice

      # translations = Utils.array_translations(SnippetTranslation, snippet_id: snippet.id)
      admin_translation_text_field(shopping_orders_status, 'shopping_orders_status', 'name_translations')
    end

    f.actions
  end
end
