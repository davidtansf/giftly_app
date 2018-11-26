require 'rails_helper'

RSpec.describe Address, type: :model do

  subject { Address.create(address_params) }
  
  context "creating new records" do

    let(:address_params) do
      {
        display_address: "1658 Market St, San Francisco, CA",
        city: "San Francisco",
        neighborhood: "Hayes Valley",
        latitude: 37.7734826,
        longitude: -122.4216396,
        map_url: "placeholder",
        cross_street: "Van Ness Ave & 12th St"
      }
    end

    context "when addressable doesn't exist" do
      it "should not create the database record" do
        expect { subject }.to change { Address.count }.by(0)
      end
    end

    context "when addressable exists" do

      let(:business) { create(:business) }

      let(:address_params) do
        {
          display_address: "1658 Market St, San Francisco, CA",
          city: "San Francisco",
          neighborhood: "Hayes Valley",
          latitude: 37.7734826,
          longitude: -122.4216396,
          map_url: "placeholder",
          cross_street: "Van Ness Ave & 12th St",
          addressable_id: business.id,
          addressable_type: business.class
        }
      end

      it "should create the database record" do
        expect { subject }.to change { Address.count }.by(1)
      end
    end
  end
end
