class AssignmentsController < ApplicationController
  # include Constants
  include AssignmentsHelper

  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  def get_assignments_by_course_instance
    if params[:course_instance_id].present?
      @assignments = Assignment.where(:course_instance_id => params[:course_instance_id])
    else
      @assignments = Assignment.where(:status => Constants::ASSIGNMENT_STATUS_ACTIVE)
    end
    # if request.xhr?
    respond_to do |format|
      format.json {render :json => @assignments} # end
    end
  end

  def active_assignments
    if validate_access_active_assignments?(current_user.id)
      active_enrollments = Enrollment.where(:user_id => current_user.id, :status => Constants::ENROLLMENT_STATUS_ACTIVE)
      active_instances = []
      active_enrollments.each do |enrollment|
        active_instances.append(enrollment.course_instance)
      end
      active_instances = active_instances.select {|instance| instance.status == Constants::COURSE_INSTANCE_STATUS_ACTIVE}
      @active_assignments = []
      active_instances.each do |instance|
        @active_assignments += instance.assignments
      end
    else
      flash[:notice] = 'You do not have permission to take this action!'
      redirect_to root_path
    end
  end

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
    @assignment.status = 'active'
    if params[:course_instance_id].present?
      # flash[:notice] = params[:course_instances_id]
      @assignment.course_instance_id = params[:course_instance_id]
    end
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html {redirect_to @assignment, notice: 'Assignment was successfully created.'}
        format.json {render :show, status: :created, location: @assignment}
      else
        format.html {render :new}
        format.json {render json: @assignment.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html {redirect_to @assignment, notice: 'Assignment was successfully updated.'}
        format.json {render :show, status: :ok, location: @assignment}
      else
        format.html {render :edit}
        format.json {render json: @assignment.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html {redirect_to assignments_url, notice: 'Assignment was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def assignment_params
    params.require(:assignment).permit(:name, :start_date, :end_date, :point, :course_instance_id, :status, :max_attempt)
  end
end
