class RemoveDebugLocale < ActiveRecord::Migration
  def change
    remove_column :admin_users, :debug_locale
  end
end
