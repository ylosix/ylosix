ActiveAdmin.register AdminUser do
  menu parent: 'Administration'

  permit_params :debug_variables, :debug_locale, :debug_template_id, :email, :locale, :password, :password_confirmation

  controller do
    def update
      if params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
      end

      super

      current_admin_user.reload
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :locale
    column :debug_variables
    column :debug_template
    column :debug_locale
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :locale
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs 'Admin Details' do
      f.input :email
      f.input :locale, as: :select, collection: Language.in_frontend.map { |lang| [lang.name, lang.locale] }, include_blank: false
      f.input :debug_variables
      f.input :debug_template
      f.input :debug_locale, as: :select, collection: Language.in_frontend.map { |lang| [lang.name, lang.locale] }, include_blank: true
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
