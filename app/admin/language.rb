# == Schema Information
#
# Table name: languages
#
#  appears_in_backoffice :boolean          default(FALSE)
#  appears_in_web        :boolean          default(FALSE)
#  created_at            :datetime
#  default               :boolean          default(FALSE)
#  flag_content_type     :string
#  flag_file_name        :string
#  flag_file_size        :integer
#  flag_updated_at       :datetime
#  id                    :integer          not null, primary key
#  locale                :string
#  name                  :string
#  updated_at            :datetime
#
# Indexes
#
#  index_languages_on_default                    (default)
#  index_languages_on_locale                     (locale)
#  index_languages_on_locale_and_appears_in_web  (locale,appears_in_web)
#

ActiveAdmin.register Language do
  menu parent: 'Locales'

  permit_params :locale, :flag, :appears_in_backoffice, :appears_in_web, :default, :name

  index do
    selectable_column
    id_column
    column :locale
    column :name
    column (:flag) { |language| image_tag(language.flag.url(:original)) if language.flag? }

    column :appears_in_backoffice
    column :appears_in_web
    column :default


    actions defaults: false do |language|
      links = link_to 'Set', change_locale_path(language.locale), class: 'member_link set_link'
      links += link_to t('active_admin.edit'), edit_admin_language_path(language), class: 'member_link edit_link'
      links += link_to t('active_admin.delete'), admin_languages_path(language), method: :delete,
                       confirm: t('active_admin.delete_confirmation'),
                       class: 'member_link delete_link'

      links.html_safe
    end
  end

  filter :locale
  filter :name
  filter :appears_in_backoffice
  filter :appears_in_web

  form do |f|
    f.inputs 'Language Details' do
      f.input :locale
      f.input :name
      f.input :flag, hint: (image_tag(f.object.flag.url(:original)) if f.object.flag?)
      f.input :appears_in_backoffice
      f.input :appears_in_web
      f.input :default
    end
    f.actions
  end
end
