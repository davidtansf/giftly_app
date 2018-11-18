# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

biz_params = {
  name: "Zuni Cafe",
  data_source: "yelp",
  data_source_id: "oqsu3pKpgRMGHj9QItsx0A",
  data_source_url: "https://www.yelp.com/biz/zuni-cafe-san-francisco-3",
  slug: "zuni-cafe",
  phone: "(415) 552-2522",
  rating: 3,
  total_reviews: 2467,
  categories: "Italian, French",
  price: 3,
  image_url: "https://s3-media2.fl.yelpcdn.com/bphoto/BBkxIeX38qarGYpW9GB6Rw/o.jpg"
}

business = Business.create(biz_params)

address_params = {
  address: "1658 Market St, San Francisco, CA",
  neighborhood: "Hayes Valley",
  latitude: 37.7734826,
  longitude: -122.4216396,
  map_url: "placeholder",
  cross_street: "Van Ness Ave & 12th St"
}

business.create_address(address_params)

review1_params = {
  rating: 4,
  review: "Zuni Cafe is considered a San Francisco institution. The likes of Ina Garten (Food Network's Beyonce) & Jennifer Garner has dined here. It's a beautiful...",
  review_url: "https://www.yelp.com/biz/zuni-cafe-san-francisco-3?hrid=e0c6t-QDP5R5bQGYhv1z0w&adjust_creative=8DSmRfg6P1KzyH41u1LHUQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=8DSmRfg6P1KzyH41u1LHUQ"
}

review2_params = {
  rating: 3,
  review: "I thought this place was just OK. I came here to celebrate a special friend's birthday and ordered the Zuni chicken to treat said friend. This chicken was...",
  review_url: "https://www.yelp.com/biz/zuni-cafe-san-francisco-3?hrid=kF4K7lJ48NrZPu2MU55oZg&adjust_creative=8DSmRfg6P1KzyH41u1LHUQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=8DSmRfg6P1KzyH41u1LHUQ"
}

review3_params = {
  rating: 4,
  review: "My sister treated me to a birthday dinner last Friday and I was so excited when I was able to snag a last minute dinner reservation for 6:15pm on a Friday...",
  review_url: "https://www.yelp.com/biz/zuni-cafe-san-francisco-3?hrid=yiQwK7WNK9G4Z89r7T3nhg&adjust_creative=8DSmRfg6P1KzyH41u1LHUQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=8DSmRfg6P1KzyH41u1LHUQ"
}

[review1_params, review2_params, review3_params].each do |params|
  business.reviews.create(params)
end

business.create_gift_card(active: true)
