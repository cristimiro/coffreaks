module Admin
  module Mutations
    class CreateCoffeeShop < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :lat, Float, required: true
      argument :long, Float, required: true
      argument :address, String, required: true
      argument :start_time, String, required: true
      argument :end_time, String, required: true

      field :coffee_shop, Types::CoffeeShopType

      def resolve(name:, lat:, long:, address:, start_time:, end_time:)
        coffee_shop = CoffeeShop.new(
          name: name,
          lat: lat,
          long: long,
          address: address,
          start_time: start_time,
          end_time: end_time
        )

        raise GraphQL::ExecutionError, coffee_shop.errors.full_messages.join(", ") unless coffee_shop.valid?

        coffee_shop.save

        {
          coffee_shop: coffee_shop
        }
      end
    end
  end
end
