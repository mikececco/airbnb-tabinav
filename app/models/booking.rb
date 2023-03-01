class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  belongs_to :review

  validates :start_date, presence: true
  validates :end_date, presence: true
end
