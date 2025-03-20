# frozen_string_literal: true

module Public
  module Types
    class CoffeeShopType < ::Types::CoffeeShopBaseType
      field :nearby, Boolean
      field :shop_details, String, null: false

      # def shop_details
      #   "#{object.location.address}, open until #{object.close_at}"
      # end
    end
  end
end
