class GiftCardsController < ApplicationController
  before_action :search_valid?, only: [:search]
  before_action :find_business, only: [:show]

  def search
    if search_valid?

      YelpBusinessAPI.search(location: params[:location], term:params[:term])
      render "index"
      # redirect_to action: 'show', slug: params[:term]
    else
      render "error_search", :status => :bad_request
    end
  end

  def show
    if @business && @business.gift_card.active?
      render "show"
    else
      render "error", :status => :bad_request
    end
  end

  private

  def find_business
    @business = Business.find_by(slug: params[:slug])
  end

  def search_valid?
    ["location", "term"].all? {|w| params.keys.include?(w) }
  end
end
