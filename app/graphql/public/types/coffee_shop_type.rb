# frozen_string_literal: true

module Public
  module Types
    class CoffeeShopType < ::Types::CoffeeShopBaseType
      field :nearby, Boolean
      field :shop_details, String, null: false

      delegate :shop, to: :object
      delegate :id, :name, to: :shop
    end
  end
end
