class RemoveSnippetTranslations < ActiveRecord::Migration
  def change
    add_column :snippets, :content, :hstore, null: false, default: {}

    SnippetTranslation.all.each do |t|
      object = t.snippet

      object.content[t.locale.to_sym] = t.content
      object.save
    end
  end
end
