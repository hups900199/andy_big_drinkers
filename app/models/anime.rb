class Anime < ApplicationRecord
  has_many :images

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, minimum: 1, maximum: 70, allow_blank: false
end
