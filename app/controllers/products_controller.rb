class ProductsController < ApplicationController
  def index
    @products = Product.includes(:image).all.order("name ASC").page params[:page]
  end

  def show
    @product = Product.find(params[:id])
  end

  def find
    @product = Product.where(type_id: params[:type]).where(image_id: params[:anime]).first
  end
end
