class RemoveSnippetTranslations < ActiveRecord::Migration
  def change
    add_column :snippets, :content_translations, :hstore, null: false, default: {}

    SnippetTranslation.all.each do |t|
      object = t.snippet

      object.content_translations[t.locale.to_sym] = t.content
      object.save
    end
  end
end
