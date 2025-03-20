require 'rails_helper'

RSpec.describe 'Admin GraphQL API', type: :request do
  subject(:request) { post '/graphql/admin', params: { query: query, variables: variables.to_json } }

  let(:query) do
    <<~GRAPHQL
      query CoffeeShops($name: String) {
        coffeeShops(name: $name) {
          __typename
          id
          name
          lat
          long
          address
          startTime
          endTime
        }
      }
    GRAPHQL
  end
  let(:variables) { { name: "Coffee Shop Name" } }

  let(:parsed_json) { JSON.parse(response.body) }

  before do
    request && parsed_json
  end

  describe "coffeeShops" do
    context "when no arguments sent" do
      let(:variables) { {} }

      it 'returns all coffeeShops' do
        expect(parsed_json["data"].present?).to be_truthy
        expect(parsed_json["data"]["coffeeShops"].size).to eq 1
      end
    end

    context "when name arguments sent" do
      it 'returns all coffeeShops' do
        expect(parsed_json["data"].present?).to be_truthy
        expect(parsed_json["data"]["coffeeShops"].size).to eq 1
        # TODO: extend test when real data and filter in place
      end
    end

    context 'when sending other primitive type' do
      let(:variables) { { name: 20 } }

      it 'return fails to fetch data error' do
        expect(parsed_json["errors"].present?).to be_truthy
      end
    end
  end
end
