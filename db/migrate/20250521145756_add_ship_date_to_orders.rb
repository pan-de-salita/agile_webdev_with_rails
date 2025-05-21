class AddShipDateToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :ship_date, :datetime, null: true
  end
end
