class Product < ApplicationRecord
  belongs_to :type
  belongs_to :image

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :stock, presence: true
  validates_length_of :name, minimum: 1, maximum: 100, allow_blank: false
end
