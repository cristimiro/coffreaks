require 'rails_helper'
require 'open-uri'

RSpec.describe CsvParser, type: :interactor do
  subject { described_class.call(csv_content: csv_content, headers: headers) }

  let(:csv_content) { CsvReader.call(csv_url: csv_url).csv_content }
  let(:csv_url) { "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }
  let(:headers) { %w[name x y] }

  describe "#call" do
    context "when csv_content and headers present" do
      it "parses the CSV with no error" do
        expect(subject.success?).to be_truthy
      end
    end

    context "when headers not present" do
      let(:headers) { nil }

      it "failse while parsing" do
        expect(subject.failure?).to be_truthy
      end
    end

    context "When csv_content is not present" do
      let(:csv_content) { nil }

      it "failse while parsing" do
        expect(subject.failure?).to be_truthy
      end
    end
  end
end
