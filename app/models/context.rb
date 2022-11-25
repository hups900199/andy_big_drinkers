class Context < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true, uniqueness: true
  validates :home, :about, presence: true
  validates_length_of :title, minimum: 1, maximum: 70, allow_blank: false
end
