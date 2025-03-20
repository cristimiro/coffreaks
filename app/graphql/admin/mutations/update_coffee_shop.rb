module Admin
  module Mutations
    class UpdateCoffeeShop < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: true
      argument :lat, Float, required: true
      argument :long, Float, required: true
      argument :address, String, required: true
      argument :start_time, String, required: true
      argument :end_time, String, required: true

      field :coffee_shop, Types::CoffeeShopType

      def resolve(id:, name:, lat:, long:, address:, start_time:, end_time:)
        coffee_shop = CoffeeShop.find_by(id: id)

        raise GraphQL::ExecutionError, "Coffee shop with ID #{id} not found." unless coffee_shop

        coffee_shop.assign_attributes(
          name: name,
          lat: lat,
          long: long,
          address: address,
          start_time: start_time,
          end_time: end_time
        )

        return { coffee_shop: coffee_shop } unless coffee_shop.changed?

        raise GraphQL::ExecutionError, coffee_shop.errors.full_messages.join(", ") unless coffee_shop.valid?

        if coffee_shop.save
          { coffee_shop: coffee_shop }
        else
          raise GraphQL::ExecutionError, coffee_shop.errors.full_messages.to_sentence
        end
      end
    end
  end
end
