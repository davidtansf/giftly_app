require 'rails_helper'

RSpec.describe GiftCard, type: :model do

  subject { GiftCard.create(params) }

  context "when business doesn't exist" do

    let(:params) do
      {
        active: true
      }
    end

    it "should not create the database record" do
      expect { subject }.to change { GiftCard.count }.by(0)
    end
  end

  context "when the business does exist" do

    subject { create(:business) }

    it "automatically creates the GiftCard" do
      expect { subject }.to change { GiftCard.count }.by(1)
    end
  end
end
