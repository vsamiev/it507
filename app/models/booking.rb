class Booking < ApplicationRecord
  paginates_per 20
  belongs_to :guest
  belongs_to :room
  belongs_to :manager
  has_one :payment

  validates_presence_of :check_in, :check_out

  filterrific(
    available_filters: [
      :is_paid,
      :manager_by,
      :state_by,
      :location_by,
    ]
    )
  scope :date_desc, -> { order("bookings.created_at desc") }

  scope :is_paid, lambda { |is_paid|
    if is_paid == 'Yes'
      date_desc.joins(:payment)
    else
      date_desc.where.not(id: Payment.all.pluck(:booking_id))
    end
  }

  scope :manager_by, lambda { |manager|
    date_desc.joins(:manager).where('managers.id = :manager', manager: manager)
  }

  scope :state_by, lambda { |state|
    date_desc.joins(:guest).where('guests.state = :state', state: state)
  }

  scope :location_by, lambda { |location|
    date_desc.joins(room: :building).where('buildings.id = :location', location: location)
  }

  def check_in=(value)
    if value.present?
      date_parts = value.split('/')
      self[:check_in] = Date.new(date_parts[2].to_i, date_parts[0].to_i, date_parts[1].to_i)
    else
      self[:check_in] = nil
    end
  end

  def check_out=(value)
    if value.present?
      date_parts = value.split('/')
      self[:check_out] = Date.new(date_parts[2].to_i, date_parts[0].to_i, date_parts[1].to_i)
    else
      self[:check_out] = nil
    end
  end

  def check_in
    return unless self[:check_in].present?
    self[:check_in].to_time.strftime('%m/%d/%Y')
  end

  def check_out
    return unless self[:check_out].present?
    self[:check_out].to_time.strftime('%m/%d/%Y')
  end

end
