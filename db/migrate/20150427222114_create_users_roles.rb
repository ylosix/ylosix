class CreateUsersRoles < ActiveRecord::Migration
  def change
    create_table :users_roles do |t|
      t.references :user, index: true
      t.references :role, index: true

      t.timestamps
    end

    add_foreign_key :users_roles, :users, on_delete: :cascade, on_update: :cascade
    add_foreign_key :users_roles, :roles, on_delete: :cascade, on_update: :cascade
  end
end
