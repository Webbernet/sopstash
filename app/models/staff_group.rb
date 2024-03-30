class StaffGroup < ApplicationRecord
  belongs_to :staff
  belongs_to :group
end
