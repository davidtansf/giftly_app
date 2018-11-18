class YelpBusinessAPI
  require 'yelp/fusion'

  DATA_SOURCE = 'yelp'

  def initialize
    @client = Yelp::Fusion::Client.new(ENV["YELP_API_KEY"])
    @business_id = nil
  end

  def search(params)

    location = params[:location]

    options = {
      :term => params[:term],
      :limit => 1
    }

    result = @client.search(location, options).businesses.last

    if result.nil?
      {
        match: false,
        slug: ""
      }
    else
      create_business_record(result)
      {
        match: true,
        slug: ""
      }
    end
  end

  def create_business_record(business)
    @business_id = business.id
    # record = Business.find_by(data_source_id: @business_id)
    record =  nil
    if record.nil?

      business = Business.create_business_client(create_params(business))
    else
      record
    end
  end

  def create_params(business)
    {
      :business => create_business_params(business),
      :address => create_address_params(business.location, business.coordinates),
      :reviews => create_reviews_params
    }
  end

  def create_business_params(business)
    {
      name: business.name,
      data_source: DATA_SOURCE,
      data_source_id: business.id,
      data_source_url: business.url,
      phone: business.display_phone,
      rating: business.rating,
      total_reviews: business.review_count,
      categories: aggregate_categories(business.categories),
      price: price_formatter(business.price),
      image_url: business.image_url
    }
  end

  def create_address_params(location, coordinates)
    {
      address: format_address(location),
      neighborhood: find_neighborhood(coordinates),
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      map_url: "placeholder",
      cross_street: find_cross_streets
    }

  end

  def format_address(location)
    line1 = "#{location.address1} #{location.address2} #{location.address3}".strip
    line2 = "#{location.city}, #{location.state}".strip
    "#{line1}, #{line2}"
  end

  def find_neighborhood(coordinates)
    #Make Call to Google Maps API
    "Your Neighborhood"
  end

  def find_cross_streets
    # Yes, we have to make another call to the Yelp API
    # The search endpoint doesn't return cross street info
    # We need to hit another endpoint for that info
    @client.business(@business_id).business.location.cross_streets
  end

  def create_reviews_params
    reviews = []
    results = @client.review(@business_id).reviews

    results.each do |review|
      reviews <<
      {
        rating: review.rating,
        review: review.text,
        review_url: format_review_url(review.id, review.url)
      }
    end

    reviews
  end

  def format_review_url(id, url)
    parsed = URI::parse(url)
    parsed.fragment = parsed.query = nil
    parsed = CGI::unescape(parsed.to_s)
    "#{parsed}?hrid=#{id}"
  end

  def aggregate_categories(categories)
    categories.map{|c| c.title}.join(", ")
  end

  def price_formatter(price)
    price.count("$")
  end

  def updater
    # Periodically updates the Yelp entries
    # Business.where.not(data_source_id: nil).pluck(:data_source_id)
  end
end
