class Payment < ApplicationRecord
  belongs_to :booking
  validates_presence_of :balance

  after_save :set_is_corporate

  filterrific(
    available_filters: [
      :balance_gte,
      :balance_lte,
      :state_by,
      :corporate_by,
      :location_by,
    ]
    )
  scope :date_desc, -> { order("payments.created_at desc") }

  scope :balance_gte, lambda { |balance|
    date_desc.where('balance >= :balance', balance: balance)
  }

  scope :balance_lte, lambda { |balance|
    date_desc.where('balance <= :balance', balance: balance)
  }

  scope :state_by, lambda { |state|
    date_desc.joins(booking: :guest).where('guests.state = :state', state: state)
  }

  scope :corporate_by, lambda { |is_corporate|
    date_desc.where('is_corporate = :is_corporate', is_corporate: is_corporate)
  }

  scope :location_by, lambda { |location|
    date_desc.joins(booking: { room: :building }).where('buildings.id = :location', location: location)
  }

  def set_is_corporate
    if self[:is_corporate].blank?
      self[:is_corporate] = 'No'
      save
    end
  end
end
