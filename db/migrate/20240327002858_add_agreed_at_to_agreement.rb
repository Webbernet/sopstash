class AddAgreedAtToAgreement < ActiveRecord::Migration[7.1]
  def change
    add_column :agreements, :agreed_at, :datetime
  end
end
