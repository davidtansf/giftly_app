require 'rails_helper'

RSpec.describe GiftCardsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #search" do
    context "when the search valid" do

      before do
        allow_any_instance_of(YelpBusinessAPI).to receive(:search).and_return({ :match => true, :slug => "LOL" })
      end

      it "returns http found" do
        post :search
        expect(response).to have_http_status(:found)
      end
    end

    context "when the search invalid" do

      before do
        allow_any_instance_of(YelpBusinessAPI).to receive(:search).and_return({ :match => false })
      end

      it "returns http bad request" do
        post :search
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET #show" do
    context "when the business doesn't exist" do
      it "returns http bad request" do
        get :show, :params => {:slug => "LOL" }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when the business does exist" do
      before do
        create(:business, :name => "taco")
      end

      it "returns http ok" do
        get :show, :params => {:slug => "taco" }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
