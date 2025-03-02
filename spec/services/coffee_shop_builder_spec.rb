require 'rails_helper'

RSpec.describe CoffeeShopBuilder, type: :service do
  subject { described_class.build(params.symbolize_keys) }

  let(:params) do
    {
      name: "Starbucks",
      x: 45.0,
      y: 45.0
    }
  end

  describe "#build" do
    it 'returns a CoffeeShop object' do
      coffee_shop = CoffeeShopBuilder.build(params)

      expect(coffee_shop).to be_a(CoffeeShop)
    end

    it 'assigns the correct name to the CoffeeShop' do
      coffee_shop = CoffeeShopBuilder.build(params)

      expect(coffee_shop.name).to eq('Starbucks')
    end

    it 'assigns the correct location to the CoffeeShop' do
      coffee_shop = CoffeeShopBuilder.build(params)

      expect(coffee_shop.location).to be_a(Location)
      expect(coffee_shop.location.lat).to eq(45.0)
      expect(coffee_shop.location.long).to eq(45.0)
    end
  end
end
