# A way to request a staff signs an article
#
class AddEmailsToArticle
  def initialize(emails:, article:)
    @emails = emails
    @article = article
  end

  def call
    @emails.map do |email|
      staff = Staff.find_or_create_by!(email:)
      agreement = Agreement.create!(staff:, article_version: @article.latest_version)
      send_agreement_email(agreement)
    end
  end

  private

  def send_agreement_email(agreement)
    StaffMailer.sop_email(agreement, true).deliver_now
  end
end
