class Guest < ApplicationRecord
  validates_presence_of :f_name, :l_name, :state

  has_many :bookings

  def full_name
    "#{f_name} #{l_name}"
  end
end
