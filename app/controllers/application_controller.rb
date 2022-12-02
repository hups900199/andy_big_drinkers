class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :initialize_session
  helper_method :cart
  helper_method :current_order

  private

  # Initialize the session for new users.
  def initialize_session
    # Empty array of product IDs
    session[:shopping_cart] ||= []
  end

  def cart
    # Pass an array of product ids and get back collection of products
    Product.find(session[:shopping_cart])
  end

  def current_order
    # Use find by id to avoid potential errors
    if session[:order_id]
      @current_order ||= Order.find(session[:order_id])
      # session[:order_id] = nil if @current_order.purchased_at
    end

    if session[:order_id].nil?
      @current_order = Order.create!
      session[:order_id] = @current_order.id
    end

    @current_order
  end
end
