class Flat < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :bookings

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :address, presence: true
  validates :city, presence: true
  validates :flat_location, presence: true
  validates :price, presence: true

  COUNTRIES = ['NL', 'FR', 'GE']
  CITIES = ['Amsterdam', 'Paris', 'Berlin']

end
