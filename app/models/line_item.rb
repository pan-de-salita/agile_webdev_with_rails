class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    price * quantity
  end

  def decrement_or_destroy
    if quantity == 1
      destroy!
    else
      decrement_quantity
    end
  end

  def decrement_quantity
    update(quantity: quantity - 1)
  end
end
