class CoffeeShop
  include ActiveModel::Model

  attr_accessor :name, :location

  def initialize(name:, location:)
    @name = name
    @location = location
  end
end
