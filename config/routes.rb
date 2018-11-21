Rails.application.routes.draw do
  get "/" => redirect("/gift_cards/zuni-cafe")
  get 'gift_cards/search'
  get 'gift_cards/:slug', to: 'gift_cards#show'
end
