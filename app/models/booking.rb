class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  has_one :review, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
end
