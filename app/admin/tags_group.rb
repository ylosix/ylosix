# == Schema Information
#
# Table name: tags_groups
#
#  created_at        :datetime         not null
#  id                :integer          not null, primary key
#  name_translations :hstore           default({}), not null
#  updated_at        :datetime         not null
#

ActiveAdmin.register TagsGroup do
  menu parent: 'Catalog'

  permit_params do
    permitted = [tags_groups_categories_attributes: [:id, :category_id, :_destroy]]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {name_translations: locales}
    permitted
  end

  index do
    selectable_column
    id_column

    column :name
    actions
  end

  filter :by_name_in,
         label: proc { I18n.t 'activerecord.attributes.tags_group.name' },
         as: :string

  show title: proc { |p| "#{p.name}" } do
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :name
    end
  end

  form do |f|
    f.inputs t('active_admin.edit_model', model: t('activerecord.models.tags_group.one')) do
      # translations = Utils.array_translations(TagsGroupTranslation, tags_group_id: tags_group.id)
      admin_translation_text_field(tags_group, 'tags_group', 'name_translations')

      f.has_many :tags_groups_categories, allow_destroy: true do |s|
        s.input :category
      end
    end
    f.actions
  end
end
