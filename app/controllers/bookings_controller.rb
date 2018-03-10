class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @payment = Payment.new

    @filterrific = initialize_filterrific(
      Booking,
      params[:filterrific]
    ) or return
    @bookings = @filterrific.find
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @booking = Booking.new
  end

  def edit
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to bookings_url, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_url, notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:check_in, :check_out, :guest_id, :room_id, :manager_id)
    end
end
