class ArticlesController < ApplicationController
  def index
    @articles = Article.all.not_archived
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
    emails = params[:emails].split(',')
    agreements = []
    Article.transaction do
      params['files'].each_with_index do |file, index|
        article = Article.create!(title: params['file_names'][index.to_s])
        article_version = ArticleVersion.create!(pid: '1.0', document: file, article:)
        agreements = emails.map do |email|
          staff = Staff.find_or_create_by!(email:)
          agreements << Agreement.create!(staff:, article_version:)
        end
      end
    end

    agreements.flatten.each do |agreement| 
     StaffMailer.sop_email(agreement, true).deliver_now
    end

    redirect_to articles_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.is_archived = true
    @article.save
    redirect_to articles_path
  end
end
