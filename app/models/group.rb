class Group < ApplicationRecord
  has_many :staff_groups
  has_many :staffs, through: :staff_groups

  has_many :articles
end
