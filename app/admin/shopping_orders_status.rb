# == Schema Information
#
# Table name: shopping_orders_statuses
#
#  color             :string
#  created_at        :datetime         not null
#  enable_invoice    :boolean
#  id                :integer          not null, primary key
#  name_translations :hstore           default({}), not null
#  updated_at        :datetime         not null
#

ActiveAdmin.register ShoppingOrdersStatus do
  menu parent: 'Orders', priority: 3, if: proc { my_site && my_site.enable_commerce_options }

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
