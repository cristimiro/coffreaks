require 'rails_helper'

RSpec.describe 'Admin::Mutations::DeleteCoffeeShop', type: :request do
  subject(:request) { post '/graphql/admin', params: { query: mutation, variables: variables.to_json } }

  let(:mutation) do
    <<~GRAPHQL
      mutation DeleteCoffeeShop(
        $id: ID!
      ) {
        deleteCoffeeShop(
          input: {
            id: $id
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
  let(:variables) { { id: 1 } }

  let(:parsed_json) { JSON.parse(response.body) }

  before do
    CoffeeShop.new(
      name: "Cristian's coffee shop",
      lat: 45.0,
      long: 45.0,
      address: "Turnu Rosu",
      start_time: "09:00",
      end_time: "21:00"
    ).save
  end

  describe ".resolve" do
    context 'when coffee shop is not found' do
      let(:variables) { { id: 2 } }

      it 'returns coffee shop not found error' do
        request

        expect(parsed_json["errors"].present?).to be_truthy
        expect(parsed_json["errors"].first["message"]).to eq "Coffee shop with ID #{variables[:id]} not found."
      end
    end

    context 'when coffee shop is found' do
      it 'deletes the coffee shop record' do
        expect(CoffeeShop.all.count).to eq 1

        request

        expect(CoffeeShop.all.count).to eq 0
      end

      it 'returns the deleted record' do
        request

        expect(parsed_json["data"].present?).to be_truthy

        shop = parsed_json["data"]["deleteCoffeeShop"]["coffeeShop"]
        expect(shop["name"]).to eq("Cristian's coffee shop")
        expect(shop["lat"]).to eq(45.0)
        expect(shop["long"]).to eq(45.0)
        expect(shop["address"]).to eq("Turnu Rosu")
        expect(shop["startTime"]).to eq("09:00")
        expect(shop["endTime"]).to eq("21:00")
      end
    end
  end
end
