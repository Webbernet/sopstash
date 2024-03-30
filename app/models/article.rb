class Article < ApplicationRecord
  has_many :article_versions
  belongs_to :group, optional: true
  accepts_nested_attributes_for :article_versions
  scope :not_archived, -> { where("is_archived = false") }

  def latest_version
    article_versions.order(:id).reverse.first
  end
end
