# == Schema Information
#
# Table name: admin_users
#
#  created_at             :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  debug_template_id      :integer
#  debug_variables        :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  id                     :integer          not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locale                 :string           default("en"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime
#
# Indexes
#
#  index_admin_users_on_email                 (email) UNIQUE
#  index_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#

ActiveAdmin.register AdminUser do
  menu parent: 'Administration', priority: 0

  permit_params :debug_variables, :debug_template_id, :email, :locale, :password, :password_confirmation

  controller do
    def update
      if params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
      end

      super

      current_admin_user.reload
      session[:locale] = current_admin_user.locale
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :locale
    column :debug_variables
    column :debug_template
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
      f.input :locale, as: :select, collection: Language.in_frontend.map { |lang| [lang.name, lang.locale] }, include_blank: true
      f.input :debug_variables
      f.input :debug_template
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
