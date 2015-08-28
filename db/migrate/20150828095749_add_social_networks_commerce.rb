class AddSocialNetworksCommerce < ActiveRecord::Migration
  def change
    add_column :commerces, :social_networks, :hstore, default: {}, null: false
  end
end
