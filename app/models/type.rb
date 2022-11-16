class Type < ApplicationRecord
  has_many :products
  has_many :images, through: :products

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates_length_of :name, minimum: 1, maximum: 70, allow_blank: false
end
