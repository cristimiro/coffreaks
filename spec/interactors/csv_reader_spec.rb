require 'rails_helper'
require 'open-uri'

RSpec.describe CsvReader, type: :interactor do
  subject { described_class.call(csv_url: csv_url) }

  describe "#call" do
    context "when valid URL" do
      let(:csv_url) { "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }

      it "does not fail" do
        expect(subject.success?).to be_truthy
      end
    end

    context "when invalid URL" do
      let(:csv_url) { "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/wrong_file.csv" }

      it "returns error" do
        expect(subject.failure?).to be_truthy
      end
    end
  end
end
