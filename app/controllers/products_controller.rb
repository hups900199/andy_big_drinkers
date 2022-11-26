class ProductsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Products", "/products/index"
    @products = Product.includes(:image).all.order("name ASC").page params[:page]
  end

  def show
    add_breadcrumb "Products", "/products/index"
    @product = Product.find(params[:id])
    add_breadcrumb @product.name
  end

  def find
    add_breadcrumb "Products", "/products/index"
    @product = Product.where(type_id: params[:type]).where(image_id: params[:anime]).first
    add_breadcrumb @product.name
  end
end
