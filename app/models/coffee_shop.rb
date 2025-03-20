class CoffeeShop < ApplicationRecord
  validates :name, :lat, :long, :address, :start_time, :end_time, presence: true
  validate :valid_location?
  validate :start_end_time_valid_interval, if: :start_end_time_valid_input

  private

  def valid_location?
    return true if Location.new(lat: lat, long: long).valid?

    errors.add(:base, "Invalid location")
  end

  def start_end_time_valid_interval
    return true if start_time.to_time < end_time.to_time

    errors.add(:time, "interval is invalid")
  end

  def start_end_time_valid_input
    return true if valid_time_format?(start_time) && valid_time_format?(end_time)

    errors.add(:time, "input is invalid") && false
  end

  def valid_time_format?(str)
    !!(str =~ /\A([01]?\d|2[0-3]):[0-5]\d\z/)
  end
end
