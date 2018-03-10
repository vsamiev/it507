class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @filterrific = initialize_filterrific(
      Payment,
      params[:filterrific]
    ) or return
    @payments = @filterrific.find
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @payment = Payment.new(booking_id: params[:booking_id])
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to bookings_url, notice: 'Payment was successfully received.'
    else
      render :new
    end
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:balance, :is_corporate, :booking_id)
    end
end
