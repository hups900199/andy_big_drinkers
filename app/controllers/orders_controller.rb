class OrdersController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    @orders = Order.where(user_id: current_user.id)

    add_breadcrumb "All Orders", orders_admin_path if current_user.admin?
    add_breadcrumb "My Orders"
  end

  def show
    @order = Order.find(params[:id])

    @line_items = Stripe::Checkout::Session.list_line_items(@order.payment)

    add_breadcrumb "All Orders", orders_admin_path if current_user.admin?
    add_breadcrumb "My Orders", orders_index_path
    add_breadcrumb @order.id
  end

  def admin
    @orders = if current_user.admin?
                Order.where.not(status: [nil])
              else
                Order.where(user_id: current_user.id)
              end

    add_breadcrumb "All Orders"
  end
end
