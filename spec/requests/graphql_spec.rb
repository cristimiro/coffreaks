require 'rails_helper'

RSpec.describe 'GraphQL API', type: :request do
  # TODO add Fabricator for CoffeeShope once working with real data
  subject(:request) { post '/graphql', params: { query: query } }
  let(:query) do
    <<~GQL
      query {
        coffeeShops#{arguments} {
          id
          name
          nearby
          shopDetails
        }
      }
    GQL
  end
  let(:parsed_json) { JSON.parse(response.body) }

  before do
    request && parsed_json
  end

  describe "coffeeShops" do
    context "when no arguments sent" do
      let(:arguments) { "" }
      it 'returns all coffeeShops' do
        expect(parsed_json["data"].present?).to be_truthy
        expect(parsed_json["data"]["coffeeShops"].size).to eq 6
      end
    end

    context 'when location arguments only' do
      context "when missing one coordinate" do
        let(:arguments) { "(userLocation: {x: 1})" }

        it 'return fails to fetch data error' do
          expect(parsed_json["errors"].present?).to be_truthy
        end
      end

      context "when correct coordinates" do
        let(:arguments) { "(userLocation: {x: 1, y: 2})" }

        it 'returns sorted coffee shops by location' do
          # TODO
        end
      end
    end

    context 'when name argument only' do
      let(:arguments) { '(name: "Shop name")' }

      it 'returns coffee shops filtered by name' do
        # TODO
      end
    end

    context "when both name and location arguments" do
      let(:arguments) { '(name: "Shop name", userLocation: {x: 1, y: 2})' }

      it 'returns coffee shops filtered by name and sorted by distance' do
        # TODO
      end
    end
  end
end
