class AddSnippetMissingIndex < ActiveRecord::Migration
  def change
    add_index :snippets, :tag
  end
end
