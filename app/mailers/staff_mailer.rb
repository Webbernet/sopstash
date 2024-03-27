class StaffMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def sop_email(agreement, is_new)
    @sop_name = agreement.article_version.article.title
    @is_new = is_new
    @agreement = agreement

    mail(to: agreement.staff.email, subject: 'New Sop to sign')
  end
end


