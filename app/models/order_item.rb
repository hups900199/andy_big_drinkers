class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  before_save :set_unit_price
  before_save :set_total

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.type.price * (100 - product.type.discount) / 100 + product.image.price * (100 - product.image.discount) / 100
    end
  end

  def total
    return unit_price * quantity
  end

  private

  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_total
    self[:total] = total * quantity
  end
end