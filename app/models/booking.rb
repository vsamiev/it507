class Booking < ApplicationRecord
  belongs_to :guest
  belongs_to :room
  belongs_to :manager
  has_one :payment

  validates_presence_of :check_in, :check_out

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
