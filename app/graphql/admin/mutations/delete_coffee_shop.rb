module Admin
  module Mutations
    class DeleteCoffeeShop < ::Mutations::BaseMutation
      argument :id, ID, required: true

      field :coffee_shop, Types::CoffeeShopType

      def resolve(id:)
        coffee_shop = CoffeeShop.find_by(id: id)

        raise GraphQL::ExecutionError, "Coffee shop with ID #{id} not found." unless coffee_shop

        if coffee_shop.destroy
          { coffee_shop: coffee_shop }
        else
          raise GraphQL::ExecutionError, coffee_shop.errors.full_messages.to_sentence
        end
      end
    end
  end
end
