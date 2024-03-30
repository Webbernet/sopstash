class CreateStaffGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :staff_groups do |t|
      t.references :staff, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
