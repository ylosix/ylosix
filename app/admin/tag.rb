ActiveAdmin.register Tag do
  menu parent: 'Catalog'

  permit_params :tags_group_id, :priority,
                tag_translations_attributes: [:id, :locale, :name, :slug]

  action_item :view, only: :show do
    link_to t('formtastic.add_another', model: t('activerecord.models.tag.one')), new_admin_tag_path
  end

  index do
    selectable_column
    id_column

    column :tags_group
    column :name
    column :slug
    column :priority
    actions
  end

  filter :translations_name, as: :string, label: proc { I18n.t 'activerecord.attributes.tag.name' }
  filter :parent
  filter :tags_group

  form do |f|
    f.inputs t('formtastic.edit_form', model: t('activerecord.models.tag.one')) do
      f.input :tags_group
      f.input :priority, hint: '1:+ --- 10:-'

      translations = Utils.array_translations(TagTranslation, tag_id: tag.id)
      admin_translation_text_field(translations, 'tag', 'name')
      admin_translation_text_field(translations, 'product', 'slug', hint: 'Chars not allowed: (Upper chars) spaces')
    end
    f.actions
  end
end
