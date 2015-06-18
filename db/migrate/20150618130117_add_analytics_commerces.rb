class AddAnalyticsCommerces < ActiveRecord::Migration
  def change
    add_column :commerces, :ga_account_id, :string, default: nil
  end
end
