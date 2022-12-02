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
    session[:order_id] = 16
  end

  def cart
    # Pass an array of product ids and get back collection of products
    Product.find(session[:shopping_cart])
  end

  def current_order
    # Use find by id to avoid potential errors
    if Order.find_by_id(session[:order_id]).nil?
      Order.new
    else
      Order.find_by_id(session[:order_id])
    end
  end
end
