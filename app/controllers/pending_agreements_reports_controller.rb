class PendingAgreementsReportsController < ApplicationController
  def show
    @agreements = Agreement.where(agreed: false)
  end
end
