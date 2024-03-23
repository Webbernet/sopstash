module ArticleVersions
  class CreateForm
    include ActiveModel::Model
    attr_accessor :article, :pid, :user, :notes

    def save
      article.article_versions.create!(
        pid:,
        user:,
        notes:
      )
    end
  end
end

