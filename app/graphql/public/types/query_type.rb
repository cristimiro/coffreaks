# frozen_string_literal: true

module Public
  module Types
    class QueryType < ::Types::BaseObject
      field :coffee_shops, [CoffeeShopType], null: false do
        argument :user_location, LocationInput, required: false
        argument :name, String, required: false
      end

      def coffee_shops(user_location: nil, name: "")
        filtered_coffee_shops = filter_coffee_shops_by_name(name: name)

        # TODO: Move upcoming logic and methods to service
        coffee_shops = []
        filtered_coffee_shops.each_with_index do |shop, index|
          coffee_shops << Presenters::CoffeeShopPresenter.new(
            shop,
            nearby: index < 3,
            shop_details: compute_shop_details_message(shop.address, shop.start_time, shop.end_time)
          )
        end

        coffee_shops
      end

      private

      def filter_coffee_shops_by_name(name:)
        unless name.blank?
          filtered_shop = CoffeeShop.find_by(name: name)
          return filtered_shop.nil? ? [] : [filtered_shop]
        end

        CoffeeShop.all
      end

      def compute_shop_details_message(address, start_time, end_time)
        details = "#{address}, "
        details.concat(shop_schedule_interval(start_time.to_time, end_time.to_time))
      end

      def shop_schedule_interval(start_time, end_time)
        if Time.current < start_time
          "opens at #{start_time.strftime('%I:%M %p')}"
        elsif (start_time..end_time).member?(Time.current)
          "open until #{end_time.strftime('%I:%M %p')}"
        else
          "opens tomorrow at #{start_time.strftime('%I:%M %p')}"
        end
      end
    end
  end
end
