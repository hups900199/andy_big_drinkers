class ContextsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def home
    @context = Context.first
    @products = Product.includes(:image).includes(:type).order("stock ASC").limit(10)
  end

  def about
    add_breadcrumb "About", "/contexts/about"
    @context = Context.first
  end
end
