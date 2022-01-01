class ShopingCart
  delegate :total_amount, to: :order
  attr_reader :order

  ZERO = 0
  private_constant :ZERO

  def initialize(order:)
    @order = order
  end

  def add_item(product_id:, quantity:)
    product = Product.find(product_id)
    order_item = @order.items.find_or_initialize_by(product_id: product_id)
    order_item.product_name = product.name
    order_item.product_category = Category.find(product.category_id).name
    order_item.product_price = product.price
    order_item.product_short_description = product.short_description
    order_item.amount = quantity.to_i * product.price.to_i
    order_item.quantity = quantity
    ActiveRecord::Base.transaction do
      order_item.save
      update_subtotal_and_save
    end
  end

  def items_count
    @order.items.sum(:quantity)
  end

  def item_quantity(product_id)
    product_item = @order.items.find_by(product_id: product_id)
    return product_item.quantity if product_item

    ZERO
  end

  def update_subtotal_and_save
    @order.total_amount = @order.items.sum('amount')
    @order.save
  end

  def clear
    @order.status = Order::CONFIRMED
    @order.save
  end
end
