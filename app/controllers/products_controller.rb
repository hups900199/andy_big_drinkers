class ProductsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    @products = Product.includes(:type).includes(:image).all.order("name ASC").page params[:page]
    @order_item = current_order.order_items.new

    add_breadcrumb "Products", "/products/index"
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new

    add_breadcrumb "Products", "/products/index"
    add_breadcrumb @product.image.name, @product.image
    add_breadcrumb @product.type.name, @product.type
    add_breadcrumb @product.name
  end

  def find
    @product = Product.where(type_id: params[:type]).where(image_id: params[:anime]).first
    @order_item = current_order.order_items.new

    add_breadcrumb "Products", "/products/index"
    add_breadcrumb @product.image.name, @product.image
    add_breadcrumb @product.type.name, @product.type
    add_breadcrumb @product.name
  end
end
