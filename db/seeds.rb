# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

address_attributes = {
  display_address: "1658 Market St, San Francisco, CA",
  city: "San Francisco",
  neighborhood: "Hayes Valley",
  latitude: 37.7734826,
  longitude: -122.4216396,
  map_url: "placeholder",
  cross_street: "Van Ness Ave & 12th St"
}

review1_params = {
  rating: 4,
  text: "Zuni Cafe is considered a San Francisco institution. The likes of Ina Garten (Food Network's Beyonce) & Jennifer Garner has dined here. It's a beautiful...",
  review_source_url: "https://www.yelp.com/biz/zuni-caf%C3%A9-san-francisco-3?hrid=e0c6t-QDP5R5bQGYhv1z0w",
  review_source_id: "e0c6t-QDP5R5bQGYhv1z0w"
}

review2_params = {
  rating: 3,
  text: "I thought this place was just OK. I came here to celebrate a special friend's birthday and ordered the Zuni chicken to treat said friend. This chicken was...",
  review_source_url: "https://www.yelp.com/biz/zuni-caf%C3%A9-san-francisco-3?hrid=kF4K7lJ48NrZPu2MU55oZg",
  review_source_id: "kF4K7lJ48NrZPu2MU55oZg"
}

review3_params = {
  rating: 4,
  text: "My sister treated me to a birthday dinner last Friday and I was so excited when I was able to snag a last minute dinner reservation for 6:15pm on a Friday...",
  review_source_url: "https://www.yelp.com/biz/zuni-caf%C3%A9-san-francisco-3?hrid=yiQwK7WNK9G4Z89r7T3nhg",
  review_source_id: "yiQwK7WNK9G4Z89r7T3nhg"
}

reviews_attributes = [review1_params, review2_params, review3_params]

biz_params = {
  name: "Zuni Café",
  data_source: "yelp",
  data_source_id: "oqsu3pKpgRMGHj9QItsx0A",
  data_source_url: "https://www.yelp.com/biz/zuni-caf%C3%A9-san-francisco-3?creative=8DSmRfg6",
  slug: "zuni-cafe",
  phone: "(415) 552-2522",
  rating: 4.5,
  total_reviews: 2467,
  categories: ["Italian", "French"],
  parent_category: "Restaurants",
  price: 3,
  image_url: "https://s3-media2.fl.yelpcdn.com/bphoto/BBkxIeX38qarGYpW9GB6Rw/o.jpg",
  address_attributes: address_attributes,
  reviews_attributes: reviews_attributes
}

Business.create(biz_params)
