class ArticlesController < ApplicationController
  def index
    @articles = Article.all.not_archived
    @pending_documents_count = Agreement.where(agreed: false).count
  end

  def show
    @article = Article.find(params[:id])
    @latest_version = @article.article_versions.order(created_at: :desc).first
  end

  def edit
    @article = Article.find(params[:id])
    @latest_version = @article.article_versions.order(created_at: :desc).first
  end

  def update
    @article = Article.find(params[:id])
    @group = Group.find(params[:article][:group_id])
    @article.update!(group: @group)

    @group.staffs.each do |staff|
      AddEmailsToArticle.new(emails: [staff.email], article: @article).call
    end

    redirect_to articles_path(@article)
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
        AddEmailsToArticle.new(emails:, article:).call
      end
    end

    redirect_to articles_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.is_archived = true
    @article.save
    redirect_to articles_path
  end


  def articles
    @group = Group.find(params[:group_id])
    article = Article.find(params[:article_id])
    @new_group_article = @group.article_groups.create!(article: article)

    AddEmailsToArticle.new(emails: @group.staffs.map(&:email), article:).call

    redirect_to group_path(@group)
  end
end
