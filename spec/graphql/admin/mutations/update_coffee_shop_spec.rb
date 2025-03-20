require 'rails_helper'

RSpec.describe 'Admin::Mutations::UpdateCoffeeShop', type: :request do
  subject(:request) { post '/graphql/admin', params: { query: mutation, variables: variables.to_json } }

  let(:mutation) do
    <<~GRAPHQL
      mutation UpdateCoffeeShop(
        $id: ID!
        $name: String!,
        $lat: Float!,
        $long: Float!,
        $address: String!,
        $end_time: String!,
        $start_time: String!
      ) {
        updateCoffeeShop(
          input: {
            id: $id,
            name: $name,
            lat: $lat,
            long: $long,
            address: $address,
            endTime: $end_time,
            startTime: $start_time
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
      id: id,
      name: "Cristian",
      lat: lat,
      long: long,
      address: "Turnu Rosu",
      start_time: start_time,
      end_time: end_time
    }
  end
  let(:id) { 1 }
  let(:lat) { 45.0 }
  let(:long) { 50.0 }
  let(:start_time) { "09:00" }
  let(:end_time) { "21:00" }
  let(:parsed_json) { JSON.parse(response.body) }
  let(:coffee_shop) do
    CoffeeShop.new(
      name: "Cristian's coffee shop",
      lat: 45.0,
      long: 45.0,
      address: "Turnu Rosu",
      start_time: "09:00",
      end_time: "21:00"
    )
  end

  before do
    coffee_shop.save
  end

  describe ".resolve" do
    context 'when coffee shop is not found' do
      let(:id) { 2 }

      it 'returns coffee shop not found error' do
        request

        expect(parsed_json["errors"].present?).to be_truthy
        expect(parsed_json["errors"].first["message"]).to eq "Coffee shop with ID #{variables[:id]} not found."
      end
    end

    context 'when coffee shop is found' do
      context 'when identical params' do
        it 'does not change updated_at' do
          request

          expect(coffee_shop.created_at).to eq coffee_shop.updated_at
        end

        it 'returns the coffee shop' do
          request

          expect(parsed_json["data"].present?).to be_truthy

          shop = parsed_json["data"]["updateCoffeeShop"]["coffeeShop"]
          expect(shop["name"]).to eq("Cristian")
          expect(shop["lat"]).to eq(45.0)
          expect(shop["long"]).to eq(50.0)
          expect(shop["address"]).to eq("Turnu Rosu")
          expect(shop["startTime"]).to eq("09:00")
          expect(shop["endTime"]).to eq("21:00")
        end
      end

      context 'when invalid params' do
        let(:lat) { 200.0 }

        it 'returns invalid locaiton error' do
          request

          expect(parsed_json["errors"].first["message"]).to eq "Invalid location"
        end
      end

      context 'when coffee shop updates' do
        let(:lat) { 20.0 }
        let(:long) { 30.0 }
        let(:start_time) { "10:00" }
        let(:end_time) { "20:00" }

        it 'updates the changed fields' do
          request

          expect(parsed_json["data"].present?).to be_truthy

          shop = parsed_json["data"]["updateCoffeeShop"]["coffeeShop"]
          expect(shop["name"]).to eq("Cristian")
          expect(shop["lat"]).to eq(20.0)
          expect(shop["long"]).to eq(30.0)
          expect(shop["address"]).to eq("Turnu Rosu")
          expect(shop["startTime"]).to eq("10:00")
          expect(shop["endTime"]).to eq("20:00")
        end
      end
    end
  end
end
