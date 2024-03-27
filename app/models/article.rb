class Article < ApplicationRecord
  has_many :article_versions
  accepts_nested_attributes_for :article_versions
  scope :not_archived, -> { where("is_archived = false") }
end
