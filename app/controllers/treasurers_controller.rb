class TreasurersController < ApplicationController
  layout "scaffold"

  before_action :set_treasurer, only: [:show, :edit, :update, :destroy, :toggle_verify,:make_principal_treasurer]
	before_action :check_admin_access, only: [:index, :destroy,:make_principal_treasurer]
	before_action :check_same_person, only: [:show, :edit, :update]

  # GET /treasurers
  def index
		if current_user.principal_treasurer?
		  @search = Treasurer.with_attached_image.where(council: current_user.treasurer.council).ransack(params[:q])
		elsif current_user.admin?
			@search = Treasurer.with_attached_image.ransack(params[:q])
		end
    @treasurers = @search.result(distinct: true).order(id: :desc).paginate(page: params[:page])
  end

  def advanced_search
    @search = Treasurer.ransack(params[:q])
    @search.build_grouping unless @search.groupings.any?
    @treasurers  = @search.result(distinct: true).order(id: :desc).paginate(page: params[:page])
  end
	
	
	
  # GET /treasurers/1
  def show
  end

  # GET /treasurers/new
  def new
		head 404 and return if current_user.treasurer.present?
    @treasurer = Treasurer.new
		@councils = BranchConnection.where(BRANCHSTATUS: "ACTIVE").order(COUNCIL: :asc).pluck(:COUNCIL).uniq
		@branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: CouncilConnection.first.COUNCIL).order(BRANCH: :asc).pluck(:BRANCH)
  end
	
	def pull_branches
		@branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: params[:council]).order(BRANCH: :asc).uniq
		branch_data = []
		@branches.map do |branch|
			branch_data << {:branch_selected => branch.BRANCH == current_user.treasurer.branch_id ? "yes" : "no", :branch_name => branch.BRANCH}
		end
		render json: branch_data.as_json 
		
  end
	

  # GET /treasurers/1/edit
  def edit
		@councils = BranchConnection.where(BRANCHSTATUS: "ACTIVE").order(COUNCIL: :asc).pluck(:COUNCIL).uniq
		@branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: @treasurer.council).order(BRANCH: :asc).pluck(:BRANCH) if @treasurer.council
		@branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: CouncilConnection.first.COUNCIL).order(BRANCH: :asc).pluck(:BRANCH) unless @treasurer.council
  end

  # POST /treasurers
  def create
		@councils = BranchConnection.where(BRANCHSTATUS: "ACTIVE").order(COUNCIL: :asc).pluck(:COUNCIL).uniq
		@branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: CouncilConnection.first.COUNCIL).order(BRANCH: :asc).pluck(:BRANCH)
    @treasurer = current_user.build_treasurer(treasurer_params)
		if params[:treasurer][:training_manual]
			@treasurer.training_manual = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:training_manual])
		end

		if params[:treasurer][:bishop_podcast]
			@treasurer.bishop_podcast = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:bishop_podcast])
		end
		
		if params[:treasurer][:born_again]
			@treasurer.born_again = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:born_again])
		end

		
		if params[:treasurer][:employment_status]
			@treasurer.employment_status = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:employment_status])
		end

		@treasurer.conference = params[:treasurer][:conference]
		@treasurer.debt = params[:treasurer][:debt]
		
    if @treasurer.save
      redirect_to @treasurer, notice: 'Treasurer Information was successfully captured.'
    else
      render :new
    end
  end

  # PATCH/PUT /treasurers/1
  def update
		@councils = BranchConnection.where(BRANCHSTATUS: "ACTIVE").order(COUNCIL: :asc).pluck(:COUNCIL).uniq
		@branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: CouncilConnection.first.COUNCIL).order(BRANCH: :asc).pluck(:BRANCH)
		if params[:treasurer][:training_manual]
			@treasurer.training_manual = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:training_manual])
		end

		if params[:treasurer][:bishop_podcast]
			@treasurer.bishop_podcast = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:bishop_podcast])
		end
		
		if params[:treasurer][:born_again]
			@treasurer.born_again = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:born_again])
		end

		
		if params[:treasurer][:employment_status]
			@treasurer.employment_status = ActiveModel::Type::Boolean.new.cast(params[:treasurer][:employment_status])
		end
		
		@treasurer.conference = params[:treasurer][:conference]
		@treasurer.debt = params[:treasurer][:debt]
		
		@treasurer.save!

    if @treasurer.update(treasurer_params)
			
      redirect_to @treasurer, notice: 'Treasurer Information was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /treasurers/1
  def destroy
    @treasurer.user.destroy
    redirect_to treasurers_url, notice: 'Treasurer was successfully removed from system.'
  end

  def toggle_verify
		head 404 and return if current_user.treasurer?
		if @treasurer.update_attributes(verified: !@treasurer.verified)
			redirect_to @treasurer, notice: 'You successsfully changed verification status of treasurer. An email has been sent'
		end
  end
	
	def make_principal_treasurer	
		head 404 and return unless current_user.admin?
		if @treasurer.user.principal_treasurer?
			@treasurer.user.treasurer!
		elsif @treasurer.user.treasurer?
			@treasurer.user.principal_treasurer!
		end		
		redirect_to @treasurer, notice: 'This treasurer is a principal treasurer now. They have admin privileges for their council'	
		
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treasurer
      @treasurer = Treasurer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def treasurer_params
      params.require(:treasurer).permit(:first_name, :middle_name, :last_name, :date_of_birth, :branch_id, :council, :phone_number, :whatsapp_number, :education_level, :ud_join, :year_treasurer, :treasurer_type, :tithe, :image, :debt_reason)
    end
	
		def check_admin_access

			redirect_to new_treasurer_path  and return if current_user.treasurer.blank?
		  redirect_to current_user.treasurer and return if (current_user.treasurer?)
	  end
	
    def check_same_person
      head 404 and return unless (@treasurer.user == current_user) || (!current_user.treasurer?)
    end
end
