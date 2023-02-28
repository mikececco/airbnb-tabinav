class Flat < ApplicationRecord
  belongs_to :user
  validates :address, presence: true
  validates :city, presence: true
  validates :flat_location, presence: true
  validates :price, presence: true
end
