class PerformancesController < ApplicationController
  layout "scaffold"

  before_action :set_performance, only: [:show, :edit, :update, :destroy]
	before_action :check_admin_head_access

  # GET /performances
  def index
		if current_user.admin?
			@performances = Performance.all.order(sunday_service: :desc)
		elsif current_user.principal_treasurer?
			@current_council = params[:council]
		  @current_branches = Branch.where(council: current_user.treasurer.council).order(branch: :asc).pluck(:branch)
			@performances = Performance.where(branch_id: @current_branches).order(sunday_service: :desc)
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
    if current_user.treasurer?
		  @treasurers = Treasurer.where(branch_id: current_user.treasurer.branch_id)
    else
      @treasurers = Treasurer.where(branch_id: @performance.branch_id)
    end
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
	
	
	def query
		pull_council_and_branches
	end
	
	def pull_council_and_branches
		unless current_user.principal_treasurer?
		  @councils = Branch.order(council: :asc).pluck(:council).uniq
			@branches = Branch.where(council: Branch.first.council).order(branch: :asc).pluck(:branch)
		else
			@councils = [current_user.treasurer.council] if current_user.principal_treasurer?
			@branches = Branch.where(council: current_user.treasurer.council).order(branch: :asc).pluck(:branch)
		end
		
		
	end

	def postquery
		@results = Hash.new{0}
		pull_council_and_branches
		@current_council = params[:council]
		@current_branches = Branch.where(council: @current_council).order(branch: :asc).pluck(:branch)
		@start_date = Date.civil(params["start_date(1i)"].to_i, params["start_date(2i)"].to_i, params["start_date(3i)"].to_i)
		@end_date = Date.civil(params["end_date(1i)"].to_i, params["end_date(2i)"].to_i, params["end_date(3i)"].to_i)
		@performances = Performance.where(branch_id: @current_branches, sunday_service: @start_date..@end_date)

		if params[:question] == "treasurer_count"
			@performances.each do |perf|
			  @results[perf.branch_id] = @results[perf.branch_id] + 1 unless (perf.who_counted && perf.who_counted.size >=2)	
			end
		end
		
		if params[:question] == "counting_start"
			@performances.each do |perf|
			  @results[perf.branch_id] = @results[perf.branch_id] + 1 if (perf.when_counted && perf.when_counted.to_i >= 4)	
			end
		end
		if params[:question] == "when_deposit"
			@performances.each do |perf|
			  @results[perf.branch_id] = @results[perf.branch_id] + 1 if (perf.when_paid && perf.when_paid.to_i > 0)
			end
		end
		
		@final_results = @results.sort_by { |branch, def_times| -def_times }
		
		render "performances/query"
		
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
