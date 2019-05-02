class CourseInstancesController < ApplicationController
  include Constants
  include CourseInstancesHelper

  before_action :set_course_instance, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin!, only: [:show, :edit, :update, :destroy, :index]
  # GET /course_instances
  # GET /course_instances.json
  def index
    @course_instances = CourseInstance.all
  end


  def my_courses
    @my_courses = current_user.course_instances
  end

  def list_assignments_of_course
    if params[:instance_id].present?
      if validate_access_list_assignments_by_course?(params[:instance_id])
        @course_instance = CourseInstance.find(params[:instance_id])
        @assignments = @course_instance.assignments
      else
        redirect_to root_path
      end
    else
      @assignments = []
      redirect_to root_path
    end
  end

  # GET /course_instances/1
  # GET /course_instances/1.json
  def show
  end

  # GET /course_instances/new
  def new
    @course_instance = CourseInstance.new
  end

  # GET /course_instances/1/edit
  def edit
  end

  # POST /course_instances
  # POST /course_instances.json
  def create
    @course_instance = CourseInstance.new(course_instance_params)

    respond_to do |format|
      if @course_instance.save
        format.html {redirect_to @course_instance, notice: 'Course instance was successfully created.'}
        format.json {render :show, status: :created, location: @course_instance}
      else
        format.html {render :new}
        format.json {render json: @course_instance.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /course_instances/1
  # PATCH/PUT /course_instances/1.json
  def update
    respond_to do |format|
      if @course_instance.update(course_instance_params)
        format.html {redirect_to @course_instance, notice: 'Course instance was successfully updated.'}
        format.json {render :show, status: :ok, location: @course_instance}
      else
        format.html {render :edit}
        format.json {render json: @course_instance.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /course_instances/1
  # DELETE /course_instances/1.json
  def destroy
    @course_instance.destroy
    respond_to do |format|
      format.html {redirect_to course_instances_url, notice: 'Course instance was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course_instance
    @course_instance = CourseInstance.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_instance_params
    params.require(:course_instance).permit(:code, :name, :description, :start_date, :end_date, :program_id, :course_id, :status)
  end

  def authorized_admin!
    if current_user.admin?

    else
      flash.now[:notice] = 'You do not have permission to perform this action'
      redirect_to root_path
    end
  end
end
