class Product < ApplicationRecord
  paginates_per 6

  has_many :order_items
  has_many :orders, through: :order_items

  belongs_to :type
  belongs_to :image

  validates :name, presence: true, uniqueness: true
  validates :stock, presence: true
  validates_length_of :name, minimum: 1, maximum: 100, allow_blank: false
end
