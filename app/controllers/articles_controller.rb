class ArticlesController < ApplicationController
  def index
  end

  def show
    @article = Article.find(params[:id])
    @latest_version = @article.article_versions.order(created_at: :desc).first
  end
  
  def edit
    @article = Article.find(params[:id])
    @latest_version = @article.article_versions.order(created_at: :desc).first
    @form = ArticleVersions::CreateForm.new(article: @article)
  end

  def new
    @article = Article.new
    version = @article.article_versions.build
  end

  def create
    article = Article.new(article_params)
    article.article_versions.first.pid = '1.0'
    article.save!
    redirect_to articles_path
  end

  def article_params
    params.require(:article).permit(:title, article_versions_attributes: [:content, :file])
  end
end
