require 'rails_helper'

RSpec.describe NearbyCoffeeShops, type: :service do
  subject { described_class.call(lat: lat, long: long) }

  describe ".call" do
    context "when input is valid" do
      let(:lat) { 47.6 }
      let(:long) { -122.4 }

      it "returns a list of 3 closest coffee shops" do
        result = subject

        expect(result.length).to eq(3)
        expect(result.first[:distance] < result.second[:distance]).to be_truthy
        expect(result.second[:distance] < result.third[:distance]).to be_truthy
      end
    end

    context "when input is invalid" do
      let(:lat) { nil }
      let(:long) { -122.4 }

      it "return an empty array" do
        expect(subject).to be_empty
      end
    end
  end
end
