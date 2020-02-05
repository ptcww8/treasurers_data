class PerformancesController < ApplicationController
  layout "scaffold"

  before_action :set_performance, only: [:show, :edit, :update, :destroy]
	before_action :check_admin_head_access

  # GET /performances
  def index
		if current_user.admin?
			@performances = Performance.all.order(sunday_service: :desc)
		elsif current_user.principal_treasurer?
			@performances = Performance.where(branch_id: current_user.treasurer.branch_id).order(sunday_service: :desc)
		else
      @performances = Performance.where(branch_id: current_user.treasurer.branch_id).order(sunday_service: :desc)
		end
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
		@performances = Performance.where(branch_id: current_user.treasurer.branch_id)
		@treasurers = Treasurer.where(branch_id: current_user.treasurer.branch_id)
  end

  # POST /performances
  def create
    @performance = Performance.new(performance_params)
		@treasurers = Treasurer.where(branch_id: current_user.treasurer.branch_id)
		@performance.who_came = params[:performance][:who_came]
		@performance.who_counted = params[:performance][:who_counted]
		@performance.branch_id = current_user.treasurer.branch_id
		@performance.completed_by = current_user.id
		
		
    if @performance.save
      redirect_to @performance, notice: 'Performance was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /performances/1
  def update
		@treasurers = Treasurer.where(branch_id: current_user.treasurer.branch_id)
    if @performance.update(performance_params)
		  @performance.who_came = params[:performance][:who_came]
		  @performance.who_counted = params[:performance][:who_counted]
		  @performance.completed_by = current_user.id
			completed_treasurer = Treasurer.find_by_id(@performance.completed_by)
			@performance.branch_id = completed_treasurer.branch_id if completed_treasurer.present?
			@performance.save
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
      params.require(:performance).permit(:service_type, :when_paid, :when_counted, :who_paid, :deposit_date, :sunday_service)
    end
	
		def check_admin_head_access
			head 404 and return if (Treasurer::TREASURER_TYPE.key(current_user.treasurer.treasurer_type) && !Treasurer::TREASURER_TYPE.key(current_user.treasurer.treasurer_type).downcase.include?("head") && current_user.treasurer?)
	  end
end
