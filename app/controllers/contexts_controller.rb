class ContextsController < ApplicationController
  def home
    @context = Context.first
    @products = Product.includes(:image).includes(:type).order("stock ASC").limit(10)
  end

  def about
    @context = Context.first
  end
end
