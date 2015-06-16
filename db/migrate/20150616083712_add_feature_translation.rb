class AddFeatureTranslation < ActiveRecord::Migration
  def change
    Feature.create_translation_table! :name => :string
  end
end
