class Business < ApplicationRecord
  has_many :reviews
  has_one :gift_card
  has_one :address, as: :addressable

  before_create :set_slug, :strip_url

  validates :name, presence: true
  validates :data_source_id, uniqueness: { scope: :data_source }
  validates :data_source, inclusion: { in: %w(yelp) }, allow_nil: true

  DEFAULT_GIFT_CARD_STATUS = true

  def self.create_business_client(params)
    instance = new(params[:business])

    ActiveRecord::Base.transaction do
      if instance.save
        instance.create_address(params[:address])


        params[:reviews].each do |review|
          instance.reviews.create(review)
        end

        instance.create_gift_card(active: DEFAULT_GIFT_CARD_STATUS)
      else
      end
    end
  end

  private

  def set_slug
    self.slug = self.name.parameterize
  end

  def strip_url
    parsed = URI::parse(self.data_source_url)
    parsed.fragment = parsed.query = nil
    self.data_source_url = CGI::unescape(parsed.to_s)
  end
end
