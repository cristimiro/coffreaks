require "rails_helper"

RSpec.describe CoffeeShop, type: :model do
  subject { described_class.new(name: name, location: location) }

  context "Validations" do
    context "when name and location present" do
      let(:name) { "CoffeeName" }
      let(:location) { Location.new(lat: 45.0, long: 45.0) }

      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "when name is not present" do
      let(:name) { nil }
      let(:location) { Location.new(lat: 45.0, long: 45.0) }

      it "is valid" do
        expect(subject).to_not be_valid
      end
    end

    context "when location is not present" do
      let(:name) { "CoffeeName" }
      let(:location) { nil }

      it "is valid" do
        expect(subject).to_not be_valid
      end
    end
  end
end
