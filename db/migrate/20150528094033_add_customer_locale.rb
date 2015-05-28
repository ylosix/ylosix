class AddCustomerLocale < ActiveRecord::Migration
  def change
    add_column :customers, :locale, :string
  end
end
