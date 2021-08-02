class RenameContentColumnToArticles < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :content, :content_body
  end
end
