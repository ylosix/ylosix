class DefaultPublicationDate < ActiveRecord::Migration
  def change
    change_column :products, :publication_date, :datetime, default: nil
  end
end
