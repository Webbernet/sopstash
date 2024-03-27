class AddIsArchivedToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :is_archived, :boolean, default: false, null: false
  end
end
