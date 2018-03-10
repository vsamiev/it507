class ManagersController < ApplicationController
  before_action :set_manager, only: [:show, :edit, :update, :destroy]

  def index
    @managers = Manager.all
  end

  def new
    @manager = Manager.new
  end

  def edit
  end

  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      redirect_to managers_url, notice: 'Manager was successfully created.'
    else
      render :new
    end
  end

  def update
    if @manager.update(manager_params)
      redirect_to managers_url, notice: 'Manager was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager
      @manager = Manager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_params
      params.require(:manager).permit(:name)
    end
end
