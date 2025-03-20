require 'rails_helper'

RSpec.describe 'Admin::Mutations::CreateCoffeeShop', type: :request do
  # TODO: Review once working with real data.
  subject(:request) { post '/graphql/admin', params: { query: mutation, variables: variables.to_json } }

  let(:mutation) do
    <<~GRAPHQL
      mutation CreateCoffeeShop(
        $name: String!,
        $lat: Float!,
        $long: Float!,
        $address: String!,
        $start_time: String!,
        $end_time: String!
      ) {
        createCoffeeShop(
          input: {
            name: $name,
            lat: $lat,
            long: $long,
            address: $address,
            startTime: $start_time,
            endTime: $end_time
          }
        ) {
          coffeeShop {
            name
            lat
            long
            address
            startTime
            endTime
          }
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      name: "Cristian",
      lat: 45.0,
      long: 50.0,
      address: "Turnu Rosu",
      start_time: "09:00",
      end_time: "21:00"
    }
  end
  let(:parsed_json) { JSON.parse(response.body) }

  describe "createCoffeeShop" do
    context "when all variables present" do
      it 'returns the newly created coffee shop' do
        request

        expect(parsed_json["data"].present?).to be_truthy

        shop = parsed_json["data"]["createCoffeeShop"]["coffeeShop"]
        expect(shop["name"]).to eq("Cristian")
        expect(shop["lat"]).to eq(45.0)
        expect(shop["long"]).to eq(50.0)
        expect(shop["address"]).to eq("Turnu Rosu")
        expect(shop["startTime"]).to eq("09:00")
        expect(shop["endTime"]).to eq("21:00")
      end
    end

    context 'when missing required fields' do
      let(:variables) do
        {
          name: "Cristian",
          lat: 45.0,
          long: 50.0,
          address: "Turnu Rosu"
        }
      end

      it 'return missing variable error' do
        request

        expect(parsed_json["errors"].present?).to be_truthy
        expect(parsed_json["errors"].sample["message"]).to include "was provided invalid value"
      end
    end
  end
end
