class AddKeepsCountToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :keeps_count, :integer, default: 0
  end
end
