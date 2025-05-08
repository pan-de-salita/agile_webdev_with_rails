class CombineItemsInCart < ActiveRecord::Migration[7.1]
  # Own attempt:
  #
  # def up
  #   Cart.all.each do |cart|
  #     cart.line_items.group_by(&:product_id).each do |product_id, items|
  #       if items.size > 1
  #         cart.line_items.create(product_id: product_id, quantity: items.size)
  #         items.each(&:destroy!)
  #       end
  #     end
  #   end
  # end
  #
  # def down
  #   Cart.all.each do |cart|
  #     cart.line_items.each do |line_item|
  #       if line_item.quantity > 1
  #         line_item.quantity.times { |_| cart.line_items.create(product_id: line_item.product.id) }
  #         line_item.destroy!
  #       end
  #     end
  #   end
  # end

  def up
    # Replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # Count the number of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        next unless quantity > 1

        # Remove individual items
        cart.line_items.where(product_id: product_id).delete_all

        # Replace with a single item
        item = cart.line_items.build(product_id: product_id)
        item.quantity = quantity
        item.save!
      end
    end
  end

  def down
    # Split items with quantity>1 into multiple items
    LineItem.where('quantity>1').each do |line_item|
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end

      # Remove original item
      line_item.destroy
    end
  end
end
