class OrderItemsController < ApplicationController
  before_action :set_order

  def create
    @order_item = @order.order_items.create(order_params)
    @order_items = current_order.order_items

    flash[:notice] = " #{@order_item.product.name} added to cart."

    redirect_back_or_to request.referrer
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.update(order_params)
    @order_items = current_order.order_items

    flash[:notice] = " #{@order_item.product.name} updated from cart."

    redirect_back_or_to request.referrer
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    @order_items = current_order.order_items

    flash[:notice] = " #{@order_item.product.name} removed from cart."

    redirect_back_or_to request.referrer
  end

  private

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end

  def set_order
    @order = current_order
  end
end
