class GiftCardsController < ApplicationController
  before_action :find_business, only: [:show]

  def search
    results = YelpBusinessAPI.new.search(location: params[:location], keyword: params[:keyword])

    # @result.save
    if results[:match]
      redirect_to action: 'show', slug: results[:slug]
    else
      @error = results[:error]
      render "error_search", :status => :bad_request
    end
  end

  def show
    if @business && @business.gift_card.active?
      render "show"
    else
      render "error_show", :status => :bad_request
    end
  end

  private

  def find_business
    @business = Business.find_by(slug: params[:slug])
  end
end
