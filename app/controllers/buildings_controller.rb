class BuildingsController < ApplicationController
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  def index
    @buildings = Building.all
  end

  def new
    @building = Building.new
  end

  def edit
  end

  def create
    @building = Building.new(building_params)
    if @building.save
      redirect_to buildings_url, notice: 'Building was successfully created.'
    else
      render :new
    end
  end

  def update
    if @building.update(building_params)
      redirect_to buildings_url, notice: 'Building was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_building
      @building = Building.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_params
      params.require(:building).permit(:name)
    end
end
