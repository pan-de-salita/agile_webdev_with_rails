class AddPayTypeToOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :pay_type
    add_reference :orders, :pay_type, null: true, foreign_key: true
  end
end
