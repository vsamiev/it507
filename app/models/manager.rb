class Manager < ApplicationRecord
  paginates_per 20
  validates_presence_of :name
  has_many :bookings
end
