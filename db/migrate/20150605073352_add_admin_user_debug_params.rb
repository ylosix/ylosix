class AddAdminUserDebugParams < ActiveRecord::Migration
  def change
    add_column :admin_users, :debug_variables, :boolean, null: false, default: false
    add_column :admin_users, :debug_template_id, :integer, null: true, default: nil
    add_column :admin_users, :debug_locale, :string, null: true, default: nil
  end
end
