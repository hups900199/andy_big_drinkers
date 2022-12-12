class Product < ApplicationRecord
  paginates_per 6

  has_many :order_items
  has_many :orders, through: :order_items

  belongs_to :type
  belongs_to :image

  validates :name, presence: true, uniqueness: true
  validates :stock, presence: true
  validates_length_of :name, minimum: 1, maximum: 100, allow_blank: false

  def aaaa
    Jbuilder.new do |product|
      product.name self.name
    end
  end

  def to_builder
    Jbuilder.new do |product|
      product.currency "cad"
      product.unit_amount ((type.price * (100 - type.discount) / 100 + image.price * (100 - image.discount) / 100)).to_i
      product.product_data self.aaaa
    end
  end
end
