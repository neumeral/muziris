require 'rails_helper'
RSpec.describe ShopingCart, type: :model do
  let(:order) { create(:order) }
  let(:current_cart) { ShopingCart.new(order: order) }
  let(:product1) { create(:product, name: 'mobile-1', price: 10_000) }

  # TODO: Strange error, calling create(:product) twice fails
  let(:product2) do
    category_id = Category.last.id
    product2 = create(:product, category_id: category_id, name: 'product-2', price: 5_000)
    product2.save
    product2
  end

  before :each do
    current_cart.add_item(product_id: product1.id, quantity: 5)
  end

  it 'can add 2 more items' do
    current_cart.add_item(product_id: product2.id, quantity: 2)
    expect(current_cart.order.total_amount).to eq(60_000)
  end

  it 'items count will be 5' do
    current_cart.add_item(product_id: product2.id, quantity: 3)
    expect(current_cart.items_count).to eq(8)
  end

  it 'item quantity of product-1 will be 5' do
    expect(current_cart.item_quantity(product1.id)).to eq(5)
  end

  it 'item quantity of product will be 0' do
    expect(current_cart.item_quantity(6)).to eq(0)
  end
end
