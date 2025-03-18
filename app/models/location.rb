class Location
  include ActiveModel::Model

  attr_accessor :lat, :long

  validates :lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :long, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  def initialize(lat:, long:)
    @lat = lat
    @long = long
  end
end
