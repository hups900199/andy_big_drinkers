class OrderItemsController < ApplicationController
  before_action :set_order

  def create
    @order_item = current_order.order_items.create(order_params)
  end

  # def update
  #   @order_item = current_order.order_items.find(params[:id])
  #   @order_item.update_attributes(order_params)
  #   # @order_item.update(quantity: params[:quantity])
  #   @order_items = current_order.order_items
  # end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    @order_items = current_order.order_items
  end

  private

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end

  def set_order
    @order = current_order
  end
end
