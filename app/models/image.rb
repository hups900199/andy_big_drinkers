class Image < ApplicationRecord
  has_many :products
  has_many :types, through: :products

  belongs_to :anime

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates_length_of :name, minimum: 1, maximum: 70, allow_blank: false
end
