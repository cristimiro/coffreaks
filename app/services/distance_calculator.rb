class DistanceCalculator
  def self.compute(coffee_shop, lat, long)
    Math.sqrt((lat - coffee_shop.location.lat)**2 + (long - coffee_shop.location.long)**2).round(4)
  end
end
