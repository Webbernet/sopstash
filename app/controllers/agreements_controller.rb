class AgreementsController < ApplicationController
 skip_before_action :require_login, only: [:show, :update]

  def show
    @agreement = Agreement.find_by(pid: params[:pid])
    if  @agreement.article_version.article.is_archived
      render html: 'Document no longer exists.'
    end
  end

  def create
    emails = params[:emails].split(',')
    article_version = ArticleVersion.find(params[:av])
    agreements = []
    emails.each do |email|
      staff = Staff.find_or_create_by!(email:)
      agreements << Agreement.create!(staff:, article_version:)
    end

    agreements.flatten.each do |agreement| 
     StaffMailer.sop_email(agreement, true).deliver_now
    end

    redirect_back(fallback_location: article_path(id: article_version.article.id) )
  end

  def update
    @agreement = Agreement.find_by(pid: params[:pid])
    @agreement.agreed = true
    @agreement.agreed_at = Time.zone.now
    @agreement.save!
    redirect_back(fallback_location: agreement_path(pid: @agreement.pid) )
  end
end
