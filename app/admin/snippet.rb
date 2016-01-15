# == Schema Information
#
# Table name: snippets
#
#  content_translations :hstore           default({}), not null
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  tag                  :string
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_snippets_on_tag  (tag)
#

ActiveAdmin.register Snippet do
  menu parent: 'Design'

  permit_params do
    permitted = [:tag]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {content_translations: locales}
    permitted
  end

  index do
    selectable_column
    id_column

    column :tag

    actions
  end

  form do |f|
    f.inputs 'Action form Details' do
      f.input :tag, hint: '{{ include snippets:tag_name }}'

      admin_translation_text_field(snippet, 'snippet', 'content_translations', component: ActiveAdminHelper::ACE)
    end

    f.actions
  end
end
