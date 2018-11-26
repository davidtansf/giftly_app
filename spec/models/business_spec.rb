require 'rails_helper'

RSpec.describe Business, type: :model do
  context "validations" do
    context "when name is blank" do

      let(:business) do
        build(:business, name: "")
      end

      it "should return errors" do
        business.valid?
        expect(business.errors[:name]).to eq(["can't be blank"])
      end
    end
  end

  describe "#price_description" do

    let(:business) do
      Business.new(price: 2)
    end
    it "returns the right description" do
      expect(business.price_description).to eq("$11-30")
    end
  end

  describe "serialize categories" do
    let!(:business) do
      create(:business, categories: ["chicken", "beef"])
    end

    it "retrives the data as an Array" do
      biz = Business.first
      expect(biz.categories).to eq(["chicken", "beef"])
    end
  end

  describe "nested_attributes" do
    context "when review and address params are passed in" do

      subject { Business.create!(params) }

      let(:params) do
        attributes_for(:business).merge(address_attributes: attributes_for(:address)).merge(reviews_attributes: [attributes_for(:review)])
      end

      it "creates a record for Business" do
        expect { subject }.to change { Address.count }.by(1)
      end

      it "creates a record for Address" do
        expect { subject }.to change { Address.count }.by(1)
      end

      it "creates a record for Review" do
        expect { subject }.to change { Review.count }.by(1)
      end
    end
  end
end
