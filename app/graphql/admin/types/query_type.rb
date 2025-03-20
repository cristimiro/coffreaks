# frozen_string_literal: true

module Admin
  module Types
    class QueryType < ::Types::BaseObject
      field :coffee_shops, [CoffeeShopType], null: false do
        argument :name, String, required: false
      end

      def coffee_shops(name: "")
        [
          {
            id: 1,
            name: "CoffeShop Sibiu",
            lat: 90.0,
            long: 90.0,
            address: "Calea poplacii",
            start_time: "09:00",
            end_time: "21:00"
          }
        ]
      end
    end
  end
end
