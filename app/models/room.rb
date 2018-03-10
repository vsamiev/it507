class Room < ApplicationRecord
  validates_presence_of :number, :building
  belongs_to :building
  has_many :bookings
  paginates_per 20
end
