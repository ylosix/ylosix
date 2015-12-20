ActiveAdmin.register Tag do
  menu parent: 'Catalog'

  permit_params do
    permitted = [:tags_group_id, :priority]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {name_translations: locales}
    permitted << {slug_translations: locales}
    permitted
  end

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

  # filter :name, label: proc { I18n.t 'activerecord.attributes.tag.name' }
  filter :tags_group

  form do |f|
    f.inputs t('formtastic.edit_form', model: t('activerecord.models.tag.one')) do
      f.input :tags_group
      f.input :priority, hint: '1:+ --- 10:-'

      # translations = Utils.array_translations(TagTranslation, tag_id: tag.id)
      admin_translation_text_field(tag, 'tag', 'name_translations')
      admin_translation_text_field(tag, 'tag', 'slug_translations', hint: 'Chars not allowed: (Upper chars) spaces')
    end
    f.actions
  end
end
