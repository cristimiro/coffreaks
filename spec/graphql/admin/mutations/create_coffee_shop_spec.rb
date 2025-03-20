require 'rails_helper'

RSpec.describe 'Admin::Mutations::CreateCoffeeShop', type: :request do
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
      lat: lat,
      long: long,
      address: "Turnu Rosu",
      start_time: start_time,
      end_time: end_time
    }
  end
  let(:lat) { 45.0 }
  let(:long) { 50.0 }
  let(:start_time) { "09:00" }
  let(:end_time) { "21:00" }
  let(:parsed_json) { JSON.parse(response.body) }

  describe ".resolve" do
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

      context 'when invalid coffee shop' do
        context 'when invalid location' do
          let(:lat) { 200.0 }

          it 'returns invalid locaiton error' do
            request

            expect(parsed_json["errors"].first["message"]).to eq "Invalid location"
          end
        end

        context 'when invalid time input' do
          let(:start_time) { "25:00" }

          it 'returns invalid time input error' do
            request

            expect(parsed_json["errors"].first["message"]).to eq "Time input is invalid"
          end
        end

        context 'when invalid time interval' do
          let(:start_time) { "21:00" }
          let(:end_time) { "09:00" }

          it 'returns invalid time input error' do
            request

            expect(parsed_json["errors"].first["message"]).to eq "Time interval is invalid"
          end
        end
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
