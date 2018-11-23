class Review < ApplicationRecord
  belongs_to :business
  validates :text, presence: true
  
  before_create do
    strip_review_url if review_source_url.present?
  end

  def strip_review_url
    parsed = URI::parse(self.review_source_url)
    parsed.fragment = parsed.query = nil
    parsed = parsed.to_s
    self.review_source_url = "#{parsed}?hrid=#{self.review_source_id}"
  end
end
