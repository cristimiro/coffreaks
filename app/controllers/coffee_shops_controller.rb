class CoffeeShopsController < ApplicationController
  before_action :validate_nearby_params, only: :nearby

  # GET /coffee_shops/nearby
  def nearby
    response = NearbyCoffeeShops.call(lat: permitted_params[:x].to_f, long: permitted_params[:y].to_f)

    render json: response.as_json
  end

  private

  def permitted_params
    params.permit(:x, :y)
  end

  def validate_nearby_params
    return if valid_coordinates?(permitted_params[:x], permitted_params[:y])

    render json: { error: "Invalid coordinates" }, status: :unprocessable_entity
  end

  def valid_coordinates?(lat, long)
    return unless valid_number?(lat.present? && lat) && valid_number?(long.present? && long)

    lat.to_f.between?(-90, 90) && long.to_f.between?(-180, 180)
  end

  def valid_number?(value)
    Float(value)
  rescue ArgumentError, TypeError
    false
  end
end
