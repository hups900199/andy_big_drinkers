class Type < ApplicationRecord
  paginates_per 6

  has_many :products
  has_many :images, through: :products

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :price, :discount, presence: true

  validates :discount, :inclusion => { :in => 0..100 }
  validates_length_of :name, minimum: 1, maximum: 70, allow_blank: false
end
