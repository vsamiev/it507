class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :edit, :update, :destroy]

  def index
    @guests = Guest.all
  end

  def new
    @guest = Guest.new
  end

  def edit
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      redirect_to guests_url, notice: 'Guest was successfully created.'
    else
      render :new
    end
  end

  def update
    if @guest.update(guest_params)
      redirect_to guests_url, notice: 'Guest was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_guest
      @guest = Guest.find(params[:id])
    end

    def guest_params
      params.require(:guest).permit(:f_name, :l_name, :state)
    end
end
