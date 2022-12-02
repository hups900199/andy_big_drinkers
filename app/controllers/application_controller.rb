class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :initialize_session
  helper_method :cart

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
end
