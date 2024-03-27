class Agreement < ApplicationRecord
  belongs_to :staff
  belongs_to :article_version

  before_create do
    self.pid = SecureRandom.uuid
  end
end
