class CoffeeShopBuilder
  def self.build(params)
    location = Location.new(lat: params[:x].to_f, long: params[:y].to_f)
    CoffeeShop.new(name: params[:name], location: location)
  end
end
