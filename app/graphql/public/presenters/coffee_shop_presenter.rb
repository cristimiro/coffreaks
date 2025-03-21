module Public
  module Presenters
    class CoffeeShopPresenter
      attr_reader :shop, :nearby, :shop_details

      def initialize(shop, nearby: false, shop_details: "")
        @shop = shop
        @nearby = nearby
        @shop_details = shop_details
      end
    end
  end
end
