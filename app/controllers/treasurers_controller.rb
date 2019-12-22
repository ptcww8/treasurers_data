class TreasurersController < ApplicationController
  layout "scaffold"

  before_action :set_treasurer, only: [:show, :edit, :update, :destroy]
	before_action :check_admin_access, only: [:index, :destroy]
	before_action :check_same_person, only: [:show, :edit, :update]

  # GET /treasurers
  def index
		@search = Treasurer.search(params[:q])
    @treasurers = @search.result(distinct: true).order(id: :desc)
  end

  # GET /treasurers/1
  def show
  end

  # GET /treasurers/new
  def new
    @treasurer = Treasurer.new
  end

  # GET /treasurers/1/edit
  def edit
  end

  # POST /treasurers
  def create
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

    if @treasurer.save
      redirect_to @treasurer, notice: 'Treasurer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /treasurers/1
  def update
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
		
		@treasurer.save!

    if @treasurer.update(treasurer_params)
			
      redirect_to @treasurer, notice: 'Treasurer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /treasurers/1
  def destroy
    @treasurer.destroy
    redirect_to treasurers_url, notice: 'Treasurer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treasurer
      @treasurer = Treasurer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def treasurer_params
      params.require(:treasurer).permit(:first_name, :middle_name, :last_name, :date_of_birth, :branch_id, :council, :phone_number, :whatsapp_number, :education_level, :ud_join, :year_treasurer, :treasurer_type, :tithe, :image)
    end
	
		def check_admin_access
		  head 404 and return if current_user.treasurer?
	  end
	
    def check_same_person
      head 404 and return unless (@treasurer.user == current_user) || (!current_user.admin?)
    end
end
