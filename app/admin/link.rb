ActiveAdmin.register Link do
  menu parent: 'Preferences'

  permit_params :class_name, :object_id, :slug, :locale, :enabled
  actions :all, except: [:edit]
end
