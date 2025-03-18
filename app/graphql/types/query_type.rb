# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :coffee_shops, [CoffeeShopType], null: false do
      argument :user_location, Types::LocationInput, required: false
      argument :name, String, required: false
    end

    def coffee_shops(user_location: nil, name: "")
      [
        {
          id: 1,
          name: "CoffeShop Sibiu",
          nearby: true,
          shop_details: "Calea Cisnadiei 15, opens at 8 PM"
        },
        {
          id: 2,
          name: "CoffeShop - default",
          nearby: false,
          shop_details: "Calea Poplacii 15, opens at 8 PM"
        },
        {
          id: 3,
          name: "CoffeShop - alt nume",
          nearby: true,
          shop_details: "Calea Victoriei 15, opens at 8 PM"
        },
        {
          id: 4,
          name: "CoffeShop - bla bla",
          nearby: false,
          shop_details: "Milea 15, opens at 9 PM"
        },
        {
          id: 5,
          name: "CoffeShop Name - test",
          nearby: false,
          shop_details: "Selimbar 15, opens at 8 PM"
        },
        {
          id: 6,
          name: "CoffeShop Name - Centru",
          nearby: true,
          shop_details: "Nicolae Blacescu 15, opens at 10 PM"
        }
      ]
    end
  end
end
