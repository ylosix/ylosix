class RenameLanguageCode < ActiveRecord::Migration
  def change
    rename_column :languages, :code, :locale
  end
end
