class CoffeeShop
  include ActiveModel::Model

  attr_accessor :name, :location

  validates :name, presence: true
  validates :location, presence: true

  def initialize(name:, location:)
    @name = name
    @location = location
  end
end
