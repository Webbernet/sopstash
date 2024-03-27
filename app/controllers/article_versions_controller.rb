class ArticleVersionsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    ready_params = article_params.merge(article: @article)
    @form = ArticleVersions::CreateForm.new(ready_params).save
    redirect_to articles_path
  end

  def article_params
    params.require(:article_versions_create_form).permit(:document, :pid, :notes)
  end
end
