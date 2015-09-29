class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :tag

      t.timestamps null: false
    end

    Snippet.create_translation_table! :content => :text
  end
end
