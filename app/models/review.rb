class Review < ApplicationRecord
  belongs_to :booking
  validates :rating, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
