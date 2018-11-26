require 'rails_helper'

RSpec.describe Review, type: :model do

  context "validations" do
    context "when text is blank" do

      let(:review) do
        build(:review, text: "")
      end

      it "should return errors" do
        review.valid?
        expect(review.errors[:text]).to eq(["can't be blank"])
      end
    end
  end

  describe "#strip_review_url" do

    let(:review) {
      build(:review, review_source_id: "zxcvbnm12345")
    }

    it "properly strips the url" do
      expect(review.strip_review_url).to eq ("http://www.yelp.com/restaurant-1?hrid=zxcvbnm12345")
    end
  end
end
