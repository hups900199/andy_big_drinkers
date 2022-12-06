class AddPaymentToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :payment, :string
    add_column :orders, :status, :string
  end
end
