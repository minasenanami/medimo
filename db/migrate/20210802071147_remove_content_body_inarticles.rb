class RemoveContentBodyInarticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :content_body, :text
  end
end
