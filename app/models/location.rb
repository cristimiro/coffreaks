class Location
  include ActiveModel::Model

  attr_accessor :lat, :long

  def initialize(lat:, long:)
    @lat = lat
    @long = long
  end
end
