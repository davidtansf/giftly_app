class YelpBusinessAPI
  attr_accessor :client

  DATA_SOURCE = 'yelp'
  RESTAURANT = 'Restaurants'

  def initialize
    @client = Yelp::Fusion::Client.new(ENV["YELP_API_KEY"])
    @business_id = nil
  end

  def search(params)
    return invalid_search_response(:params) unless search_params_valid?(params)

    location = params[:location]

    options = {
      :term => params[:keyword],
      :limit => 1
    }

    result = @client.search(location, options).businesses.last

    return invalid_search_response(:no_search_results) if result.blank?

    instance = find_or_create_business_record(result)

    if instance.valid?
      valid_search_response(instance.slug)
    else
      invalid_search_response(:validations)
    end

  rescue StandardError
    invalid_search_response(:other)
  end

  def updater
    # Periodically updates the Yelp entries
    # Business.where.not(data_source_id: nil).pluck(:data_source_id)
  end

  private

  def valid_search_response(slug)
    {
      match: true,
      slug: slug
    }
  end

  def invalid_search_response(error_type)
    error_message = case error_type
    when :params
      "Search params are missing or blank"
    when :no_search_results
      "0 search results"
    when :validations
      "Could not create database entry. Required fields missing"
    else
      "Some other error. Please try again later"
    end
    {
      match: false,
      error: error_message
    }
  end

  def search_params_valid?(params)
    !params[:location].blank? && !params[:keyword].blank?
  end

  def find_or_create_business_record(business)
    @business_id = business.id

    Business.find_by(data_source_id: @business_id) ||
        Business.create(build_params(business))
  end

  def build_params(business)
    {
      name: business.name,
      data_source: DATA_SOURCE,
      data_source_id: business.id,
      data_source_url: business.url,
      phone: business.display_phone,
      rating: business.rating,
      total_reviews: business.review_count,
      categories: aggregate_categories(business.categories),
      parent_category: RESTAURANT,
      price: price_formatter(business.price),
      image_url: business.image_url,
      address_attributes: build_address_params(business.location, business.coordinates),
      reviews_attributes: build_reviews_params
    }
  end

  def build_address_params(location, coordinates)
    {
      display_address: format_display_address(location),
      city: location.city,
      neighborhood: find_neighborhood(coordinates),
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      map_url: "placeholder",
      cross_street: find_cross_streets
    }
  end

  def build_reviews_params
    results = @client.review(@business_id).reviews

    results.map do |review|
      {
        rating: review.rating,
        text: review.text,
        review_source_id: review.id,
        review_source_url: review.url
      }
    end
  end

  def format_display_address(location)
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

  def aggregate_categories(categories)
    categories.map{|c| c.title}
  end

  def price_formatter(price)
    price.count("$")
  end
end
