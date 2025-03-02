class CoffeeShopsController < ApplicationController
  # GET /coffee_shops/nearby
  def nearby
    render json: { message: "Return" }
  end
end
