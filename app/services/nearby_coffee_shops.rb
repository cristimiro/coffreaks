class NearbyCoffeeShops
  def self.call(lat:, long:)
    return [] unless lat && long

    response = CsvProcessor.call(csv_url: "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv", headers: %w[name x y])
    if response.success?
      coffee_shops = build_coffee_shops(response.csv_line_items)
      coffee_shops_with_distance = coffee_shops_with_distance(coffee_shops, lat, long).sort_by { |entry| entry[:distance] }.take(3)
      coffee_shops_with_distance.map do |record|
        {
          name: record[:shop].name,
          location: record[:shop].location,
          distance: record[:distance]
        }
      end
    else
      []
    end
  end

  private

  def self.build_coffee_shops(coffee_shops_line_items)
    coffee_shops_line_items.map do |coffee_shops_line_item|
      CoffeeShopBuilder.build(coffee_shops_line_item.symbolize_keys)
    end
  end

  def self.coffee_shops_with_distance(coffee_shops, lat, long)
    coffee_shops.map do |coffee_shop|
      { shop: coffee_shop, distance: DistanceCalculator.compute(coffee_shop, lat, long) }
    end
  end
end
