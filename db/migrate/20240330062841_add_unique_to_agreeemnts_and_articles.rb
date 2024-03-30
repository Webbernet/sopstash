class AddUniqueToAgreeemntsAndArticles < ActiveRecord::Migration[7.1]
  def change
    add_index :agreements, [:staff_id, :article_version_id], unique: true
  end
end
