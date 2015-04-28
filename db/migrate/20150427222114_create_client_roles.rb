class CreateClientRoles < ActiveRecord::Migration
  def change
    create_table :client_roles do |t|
      t.references :client, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
