# == Schema Information
#
# Table name: tags
#
#  created_at        :datetime         not null
#  href_translations :hstore           default({}), not null
#  id                :integer          not null, primary key
#  name_translations :hstore           default({}), not null
#  priority          :integer          default(1), not null
#  slug_translations :hstore           default({}), not null
#  tags_group_id     :integer
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_tags_on_tags_group_id  (tags_group_id)
#

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
    link_to t('active_admin.new_model', model: t('activerecord.models.tag.one')), new_admin_tag_path
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

  filter :by_name_in,
         label: proc { I18n.t 'activerecord.attributes.tag.name' },
         as: :string

  filter :tags_group

  show title: proc { |p| "#{p.name}" } do
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :name
    end
  end

  form do |f|
    f.inputs t('active_admin.edit_model', model: t('activerecord.models.tag.one')) do
      f.input :tags_group
      f.input :priority, hint: '1:+ --- 10:-'

      admin_translation_text_field(tag, 'tag', 'name_translations')
      admin_translation_text_field(tag, 'tag', 'slug_translations', hint: 'Chars not allowed: (Upper chars) spaces')
    end
    f.actions
  end
end
