class CreateTagsGroups < ActiveRecord::Migration
  def change
    create_table :tags_groups do |t|
      t.string :name

      t.timestamps null: false
    end

    TagsGroup.create_translation_table! :name => :string
  end
end
