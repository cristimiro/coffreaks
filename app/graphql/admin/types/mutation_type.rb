# frozen_string_literal: true

module Admin
  module Types
    class MutationType < ::Types::BaseObject
      field :create_coffee_shop, mutation: Mutations::CreateCoffeeShop
      field :delete_coffee_shop, mutation: Mutations::DeleteCoffeeShop
    end
  end
end
