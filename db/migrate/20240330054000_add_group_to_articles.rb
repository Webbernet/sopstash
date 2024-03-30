class AddGroupToArticles < ActiveRecord::Migration[7.1]
  def change
    add_reference :articles, :group, null: true, foreign_key: true
  end
end
