class PerformancesController < ApplicationController
  layout "scaffold"

  before_action :set_performance, only: [:show, :edit, :update, :destroy]

  # GET /performances
  def index
    @performances = Performance.all
		@treasurers = Treasurer.where(branch_id:current_user.treasurer.branch_id)
  end

  # GET /performances/1
  def show
  end

  # GET /performances/new
  def new
    @performance = Performance.new
		@performances = Performance.where(branch_id: current_user.treasurer.branch_id)
		@treasurers = Treasurer.where(branch_id: current_user.treasurer.branch_id)
  end

  # GET /performances/1/edit
  def edit
  end

  # POST /performances
  def create
    @performance = Performance.new(performance_params)

    if @performance.save
      redirect_to @performance, notice: 'Performance was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /performances/1
  def update
    if @performance.update(performance_params)
      redirect_to @performance, notice: 'Performance was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /performances/1
  def destroy
    @performance.destroy
    redirect_to performances_url, notice: 'Performance was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance
      @performance = Performance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def performance_params
      params.require(:performance).permit(:who_came, :who_counted, :when_counted, :when_paid, :who_paid)
    end
end
