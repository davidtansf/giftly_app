class Business < ApplicationRecord
  has_many :reviews
  has_one :gift_card
  has_one :address, as: :addressable

  before_create do
    set_slug
    strip_url if data_source_url.present?
    set_gift_card
  end

  validates :name, presence: true
  validates :data_source_id, uniqueness: { scope: :data_source }
  validates :data_source, inclusion: { in: %w(yelp) }, allow_nil: true

  serialize :categories, Array

  accepts_nested_attributes_for :reviews, :gift_card, :address

  DEFAULT_GIFT_CARD_STATUS = true

  private

  def set_slug
    self.slug = self.name.parameterize
  end

  def strip_url
    parsed = URI::parse(self.data_source_url)
    parsed.fragment = parsed.query = nil
    self.data_source_url = parsed.to_s
  end

  def set_gift_card
    self.build_gift_card(active: DEFAULT_GIFT_CARD_STATUS)
  end
end
