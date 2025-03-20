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
  let(:parsed_json) { JSON.parse(response.body) }
  let(:coffee_shop1) do
    CoffeeShop.new(
      name: "Cristian's coffee shop",
      lat: 45.0,
      long: 45.0,
      address: "Turnu Rosu",
      start_time: "09:00",
      end_time: "21:00"
    )
  end
  let(:coffee_shop2) do
    CoffeeShop.new(
      name: "Deea's coffee shop",
      lat: 50.0,
      long: 50.0,
      address: "Sibiu",
      start_time: "09:00",
      end_time: "21:00"
    )
  end

  describe "coffeeShops" do
    before do
      coffee_shop1.save && coffee_shop2.save
    end

    context "when no arguments sent" do
      let(:variables) { {} }

      it 'returns all coffeeShops' do
        request

        expect(parsed_json["data"].present?).to be_truthy
        expect(parsed_json["data"]["coffeeShops"].size).to eq 2
      end
    end

    context "when name arguments sent" do
      let(:variables) { { name: "Cristian's coffee shop" } }

      it 'returns all coffeeShops' do
        request

        expect(parsed_json["data"].present?).to be_truthy
        expect(parsed_json["data"]["coffeeShops"].size).to eq 1
      end
    end

    context 'when sending other primitive type' do
      let(:variables) { { name: 20 } }

      it 'return fails to fetch data error' do
        request

        expect(parsed_json["errors"].present?).to be_truthy
      end
    end
  end
end
