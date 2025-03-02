require 'rails_helper'

RSpec.describe DistanceCalculator, type: :service do
  subject { described_class.compute(coffee_shop, lat, long) }

  let(:coffee_shop) { CoffeeShop.new(name: "Starbucks", location: location) }
  let(:location) { Location.new(lat: 45.0, long: 45.0) }

  describe "#compute" do
    context "when the coordinates are the same as the coffee shop's location" do
      let(:lat) { 45.0 }
      let(:long) { 45.0 }

      it "returns 0.0" do
        expect(subject).to eq(0.0)
      end
    end

    context "when the coordinates are different" do
      let(:lat) { 50.0 }
      let(:long) { 50.0 }

      it "computes the correct distance rounded to 4 decimal places" do
        expect(subject).to eq(7.0711)
      end
    end

    context "when the coordinates are negative" do
      let(:lat) { -45.0 }
      let(:long) { -45.0 }

      it "computes the correct distance rounded to 4 decimal places" do
        expect(subject).to eq(127.2792)
      end
    end
  end
end
