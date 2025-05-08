class AddPricesToExistingLineItems < ActiveRecord::Migration[7.1]
  def up
    LineItem.all.each do |line_item|
      line_item.update!(price: line_item.product.price)
    end
  end

  def down
    LineItem.all.each do |line_item|
      line_item.update!(price: 0.00)
    end
  end
end
