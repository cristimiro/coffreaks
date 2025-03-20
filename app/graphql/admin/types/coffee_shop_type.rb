# frozen_string_literal: true

module Admin
  module Types
    class CoffeeShopType < ::Types::CoffeeShopBaseType
      field :lat, Float, null: false
      field :long, Float, null: false
      field :address, String, null: false
      field :start_time, String, null: false
      field :end_time, String, null: false
    end
  end
end
