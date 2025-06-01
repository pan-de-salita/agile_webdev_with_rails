# == Schema Information
#
# id         :integer         not null
# product_id :integer         not null
# cart_id    :integer
# created_at :datetime        not null
# updated_at :datetime        not null
# quantity   :integer
# price      :decimal
# order_id   :integer
# ==
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

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
