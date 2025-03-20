require "rails_helper"

RSpec.describe CoffeeShop, type: :model do
  subject { described_class.new(params) }

  let(:params) do
    {
      name: "Cristian",
      lat: lat,
      long: long,
      address: "Turnu Rosu",
      start_time: start_time,
      end_time: end_time
    }
  end
  let(:lat) { 45.0 }
  let(:long) { 45.0 }
  let(:start_time) { "09:00" }
  let(:end_time) { "21:00" }

  describe "#valid?" do
    it { is_expected.to be_valid }

    context 'when invalid lat' do
      let(:lat) { 200.0 }

      it { is_expected.not_to be_valid }
    end

    context 'when invalid long' do
      let(:long) { 200.0 }

      it { is_expected.not_to be_valid }
    end

    context 'when invalid start time' do
      let(:start_time) { "-09:00" }

      it { is_expected.not_to be_valid }
    end

    context 'when invalid end time' do
      let(:start_time) { "33:00" }

      it { is_expected.not_to be_valid }
    end

    context 'when invalid interval' do
      let(:start_time) { "21:00" }
      let(:end_time) { "09:00" }

      it { is_expected.not_to be_valid }
    end
  end
end
