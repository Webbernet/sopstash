class CreateArticleVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :article_versions do |t|
      t.string :pid, null: false
      t.text :notes
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
