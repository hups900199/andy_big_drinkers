class Anime < ApplicationRecord
  paginates_per 10

  has_many :images

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, minimum: 1, maximum: 150, allow_blank: false
end
