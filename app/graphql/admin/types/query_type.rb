# frozen_string_literal: true

module Admin
  module Types
    class QueryType < ::Types::BaseObject
      field :coffee_shops, [CoffeeShopType], null: false do
        argument :name, String, required: false
      end

      def coffee_shops(name: "")
        unless name.blank?
          filtered_shop = CoffeeShop.find_by(name: name)
          return filtered_shop.nil? ? [] : [filtered_shop]
        end

        CoffeeShop.all
      end
    end
  end
end
