class ContextsController < ApplicationController
  def home
    @context = Context.first
    @products = Product.includes(:image).includes(:type).order("stock ASC").limit(10)

    @order_item = current_order.order_items.new
  end

  def about
    @context = Context.first

    add_breadcrumb "Home", :root_path
    add_breadcrumb "About", "/contexts/about"
  end
end
