class CartController < ApplicationController
  def create
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i

    # Push id to the end of array
    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      product = Product.find(id)
      flash[:notice] = " #{product.name} added to cart."
    end

    redirect_to products_path
  end

  def destroy; end
end
