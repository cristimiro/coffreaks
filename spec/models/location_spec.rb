require "rails_helper"

RSpec.describe Location, type: :model do
  subject { described_class.new(lat: lat, long: long) }

  context "Validations" do
    context "when latitude and longitude are valid" do
      let(:lat) { 45.0 }
      let(:long) { -45.0 }

      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context 'when latitude is out of valid range' do
      let(:lat) { 200.0 }
      let(:long) { -45.0 }

      it 'is not valid' do
        expect(subject).to_not be_valid
      end
    end

    context 'when latitude is nil' do
      let(:lat) { nil }
      let(:long) { -45.0 }

      it 'is not valid' do
        expect(subject).to_not be_valid
      end
    end

    context 'when longitude is out of valid range' do
      let(:lat) { 45.0 }
      let(:long) { -200.0 }

      it 'is not valid' do
        expect(subject).to_not be_valid
      end
    end

    context 'when longitude is nil' do
      let(:lat) { 45.0 }
      let(:long) { nil }

      it 'is not valid' do
        expect(subject).to_not be_valid
      end
    end
  end
end
