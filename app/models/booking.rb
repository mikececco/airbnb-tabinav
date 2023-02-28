class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true
  validates :status, presence: true
end
