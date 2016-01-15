# == Schema Information
#
# Table name: features
#
#  created_at        :datetime         not null
#  id                :integer          not null, primary key
#  name_translations :hstore           default({}), not null
#  priority          :integer          default(1), not null
#  updated_at        :datetime         not null
#

ActiveAdmin.register Feature do
  menu parent: 'Catalog'

  permit_params do
    permitted = [:priority]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {name_translations: locales}
    permitted
  end

  action_item :view, only: :show do
    link_to t('formtastic.add_another', model: t('activerecord.models.feature.one')), new_admin_feature_path
  end

  index do
    selectable_column
    id_column

    column :name
    column :priority
    actions
  end

  filter :by_name_in,
         label: proc { I18n.t 'activerecord.attributes.feature.name' },
         as: :string
  filter :priority

  show title: proc { |p| "#{p.name}" } do
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :name
      row :priority
    end
  end

  form do |f|
    f.inputs t('formtastic.edit_form', model: t('activerecord.models.feature.one')) do
      admin_translation_text_field(feature, 'feature', 'name_translations')

      f.input :priority, hint: '1:+ --- 10:-'
    end

    f.actions
  end
end
