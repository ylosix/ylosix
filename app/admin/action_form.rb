# == Schema Information
#
# Table name: action_forms
#
#  body_translations    :hstore           default({}), not null
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  mapping              :hstore           default({}), not null
#  subject_translations :hstore           default({}), not null
#  tag                  :string
#  updated_at           :datetime         not null
#

ActiveAdmin.register ActionForm do
  menu parent: 'Preferences'

  permit_params do
    permitted = [:tag, :mapping]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {subject_translations: locales}
    permitted << {body_translations: locales}
    permitted
  end

  index do
    selectable_column
    id_column

    column :tag
    column :mapping

    actions
  end

  filter :tag

  form do |f|
    f.inputs 'Action form details' do
      f.input :tag
      f.input :mapping, hint: 'ex: "email" => "reply-to"', as: :text

      admin_translation_text_field(action_form, 'action_form', 'subject_translations')
      admin_translation_text_field(action_form, 'action_form', 'body_translations', component: ActiveAdminHelper::CK_EDITOR)
    end

    f.actions
  end

  show title: proc { |p| "#{p.tag}" } do
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :tag
      row :subject
      row :body
    end
  end

  controller do
    def update
      super

      @action_form[:mapping] = {}
      JSON.parse(params[:action_form][:mapping].gsub('=>', ':')).each do |k, v|
        @action_form[:mapping][k] = v
      end

      @action_form.save
    end
  end
end
