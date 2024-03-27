class AddPidToAgreement < ActiveRecord::Migration[7.1]
  def change
    add_column :agreements, :pid, :string, null: false
  end
end
