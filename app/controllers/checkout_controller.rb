class CheckoutController < ApplicationController
  def format_taxes(name, percentage, description)
    {
      quantity:   1,
      price_data: {
        currency:     "cad",
        unit_amount:  (current_order.subtotal * percentage / 100).to_i,
        product_data: {
          name:        "#{name} #{percentage}%",
          description: description
        }
      }
    }
  end

  def create
    if user_signed_in?
      current_user.update(province_id: params[:province_id])
      current_order.update(user_id: current_user.id)
    end

    @selected_province = Province.find(params[:province_id])

    @session = Stripe::Checkout::Session.create(
      shipping_address_collection: { allowed_countries: ["US", "CA"] },
      payment_method_types:        [:card],
      success_url:                 checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:                  checkout_cancel_url,
      mode:                        "payment",
      line_items:                  current_order.order_items.collect do |item|
                                     item.to_builder.attributes!
                                   end
      .append(format_taxes("GST", @selected_province.GST, "Goods and Services Taxes"))
      .append(format_taxes("HST", @selected_province.HST, "Harmonized Sales Taxes"))
      .append(format_taxes("PST", @selected_province.PST, "Provincial and Services Taxes"))
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    # we took the customer's money
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id], {limit: 99})

    current_order.update(total: @session.amount_total, payment: params[:session_id],
                         status: @session.payment_status)
  end

  def cancel
    # something went wrong with payment

    redirect_to cart_show_path
  end
end
