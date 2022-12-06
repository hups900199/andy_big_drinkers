class CheckoutController < ApplicationController
  def format_taxes(name, percentage, description)
    array =
    {
      quantity:    1,
      price_data: {
        currency: "cad",
        unit_amount: (current_order.subtotal * percentage / 100).to_i,
        product_data: {
            name:         "#{name} #{percentage}%",
            description:  description
        }
      }
    }

    return array
  end

  def create
    if user_signed_in?
      current_user.update(province_id: params[:province_id])
    end

    @selected_province = Province.find(params[:province_id])

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [:card],
      success_url:          checkout_success_url,
      cancel_url:           checkout_cancel_url,
      mode:                 'payment',
      line_items:           current_order.order_items.collect { |item| item.to_builder.attributes! }
      .append(format_taxes("GST", @selected_province.GST, "Goods and Services Taxes"))
      .append(format_taxes("HST", @selected_province.HST, "Harmonized Sales Taxes"))
      .append(format_taxes("PST", @selected_province.PST, "Provincial and Services Taxes"))
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    # we took the customer's money
  end

  def cancel
    # something went wrong with payment
  end
end
