# frozen_string_literal: true

module Types
  class CoffeeShopType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :nearby, Boolean
    field :shop_details, String, null: false

    # def shop_details
    #   "#{object.location.address}, open until #{object.close_at}"
    # end
  end
end
