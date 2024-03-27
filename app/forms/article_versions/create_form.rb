module ArticleVersions
  class CreateForm
    include ActiveModel::Model
    attr_accessor :article, :pid, :notes, :document

    def save
      article.article_versions.create!(
        pid:,
        notes:,
        document:
      )
    end
  end
end

