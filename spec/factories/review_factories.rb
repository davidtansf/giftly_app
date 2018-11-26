FactoryBot.define do
  factory :review do
    rating { 4 }
    text { "This place is awesome!"}
    review_source_id { "xyz789" }
    review_source_url { "http://www.yelp.com/restaurant-1"}
  end
end
