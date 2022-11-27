class ContextsController < ApplicationController
  add_breadcrumb "Home", :root_path

  def home
    @context = Context.first
    @products = Product.includes(:image).includes(:type).order("stock ASC").limit(10)
  end

  def about
    @context = Context.first

    add_breadcrumb "About", "/contexts/about"
  end
end
