# frozen_string_literal: true

module Admin
  module Types
    class MutationType < ::Types::BaseObject
      field :create_coffee_shop, mutation: Mutations::CreateCoffeeShop
    end
  end
end
