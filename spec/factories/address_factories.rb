FactoryBot.define do
  factory :address do
    display_address { "123 Main St., Anytown, CA" }
    city { "Anytown" }
    neighborhood { "This neighborhood" }
    latitude { 35.35 }
    longitude { 57.57 }
    map_url { "https://www.map.com" }
    cross_street { "1st Ave. and Main St." }
  end
end
