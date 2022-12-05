class CheckoutController < ApplicationController
  def create
    # establish a connection with Stripe and then redirect the user to the payment screen
    @product = Product.find(params[:product_id])

    if @product.nil?
      redirect_to root_path
      return
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [:card],
      success_url:          checkout_success_url,
      cancel_url:           checkout_cancel_url,
      mode: 'payment',
      line_items:           [
        {
          quantity:    1, # hard code not good to do but for testing only
          price_data: {
            currency: "cad",
            unit_amount: @product.image.price.to_i,
            product_data: {
                name: @product.name,
                description: @product.image.anime.description,
            }
          }
        }
      ]
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
