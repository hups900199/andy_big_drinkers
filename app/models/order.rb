class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  before_save :set_subtotal

  belongs_to :user, optional: true

  validates :user_id, presence: false
  validates :payment, presence: false, uniqueness: true

  def subtotal
    order_items.collect do |order_item|
      order_item.valid? ? order_item.unit_price * order_item.quantity : 0
    end.sum
  end

  private

  def set_subtotal
    self[:subtotal] = subtotal
  end
end
