require 'rails_helper'

RSpec.describe Public::Types::CoffeeShopType do
  it 'has the expected fields' do
    expect(described_class).to have_field(:id).of_type('ID!')
    expect(described_class).to have_field(:name).of_type('String!')
    expect(described_class).to have_field(:nearby).of_type('Boolean')
    expect(described_class).to have_field(:shop_details).of_type('String!')
  end
end
