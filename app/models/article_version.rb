class ArticleVersion < ApplicationRecord
  belongs_to :article
  has_one_attached :document
end

