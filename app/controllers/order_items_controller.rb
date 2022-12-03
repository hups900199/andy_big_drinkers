class OrderItemsController < ApplicationController
  before_action :set_order

  def create
    @order_item = current_order.order_items.create(order_params)
  end

  def update
    @order_item = current_order.order_items.find(params[:id])
    # @order_item.update_attributes(order_params)
    # @order_item.update(quantity: params[:quantity])
    @order_item.update(order_params)
    @order_items = current_order.order_items
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    @order_items = current_order.order_items

    #It will dictate what format the action will respond to
    respond_to do |format|
      # when responding to a html request, it will respond by going into /app/views/students/destroy.html.erb
      format.html

      #when responding to a json request, it will respond by generating js code located in /app/views/students/destroy.js.erb
      format.js
    end
  end

  private

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end

  def set_order
    @order = current_order
  end
end
