class CreateAgreements < ActiveRecord::Migration[7.1]
  def change
    create_table :agreements do |t|
      t.references :staff, null: false, foreign_key: true
      t.references :article_version, null: false, foreign_key: true
      t.boolean :agreed, null: false, default: false

      t.timestamps
    end
  end
end
