FactoryBot.define do
  factory :business do
    name { "Taco Bell" }
    data_source  { "yelp" }
    data_source_id { "abc123" }
    data_source_url { "http//www.yelp.com/taco-bell-2" }
    phone { "415-222-3333" }
    rating { 4.5 }
    total_reviews { 1500 }
    categories { ["Mexican", "Fast Food"] }
    parent_category { "Restaurants" }
    price { 3 }
    image_url { "http://www.image.com" }
  end
end
