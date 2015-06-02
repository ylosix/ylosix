class AddLanguageAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :locale, :string, default: 'en', null: false

    Customer.update_all(:locale => 'en')
    change_column :customers, :locale, :string, default: 'en', null: false
  end
end
