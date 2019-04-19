class GradedRubricsController < ApplicationController
  before_action :set_graded_rubric, only: [:show, :edit, :update, :destroy]

  # GET /graded_rubrics
  # GET /graded_rubrics.json
  def index
    @graded_rubrics = GradedRubric.all
  end

  # GET /graded_rubrics/1
  # GET /graded_rubrics/1.json
  def show
  end

  # GET /graded_rubrics/new
  def new
    @graded_rubric = GradedRubric.new
  end

  # GET /graded_rubrics/1/edit
  def edit
  end

  # POST /graded_rubrics
  # POST /graded_rubrics.json
  def create
    @graded_rubric = GradedRubric.new(graded_rubric_params)

    respond_to do |format|
      if @graded_rubric.save
        format.html { redirect_to @graded_rubric, notice: 'Graded rubric was successfully created.' }
        format.json { render :show, status: :created, location: @graded_rubric }
      else
        format.html { render :new }
        format.json { render json: @graded_rubric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graded_rubrics/1
  # PATCH/PUT /graded_rubrics/1.json
  def update
    respond_to do |format|
      if @graded_rubric.update(graded_rubric_params)
        format.html { redirect_to @graded_rubric, notice: 'Graded rubric was successfully updated.' }
        format.json { render :show, status: :ok, location: @graded_rubric }
      else
        format.html { render :edit }
        format.json { render json: @graded_rubric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graded_rubrics/1
  # DELETE /graded_rubrics/1.json
  def destroy
    @graded_rubric.destroy
    respond_to do |format|
      format.html { redirect_to graded_rubrics_url, notice: 'Graded rubric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graded_rubric
      @graded_rubric = GradedRubric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graded_rubric_params
      params.require(:graded_rubric).permit(:rubric_id, :type, :status, :point, :cr1_des, :cr1_score, :cr1_enable, :cr2_des, :cr2_score, :cr2_enable, :cr3_des, :cr3_score, :cr3_enable, :cr4_des, :cr4_score, :cr4_enable, :cr5_des, :cr5_score, :cr5_enable, :cr6_des, :cr6_score, :cr6_enable, :cr7_des, :cr7_score, :cr7_enable, :cr8_des, :cr8_score, :cr8_enable, :cr9_des, :cr9_score, :cr9_enable, :cr10_des, :cr10_score, :cr10_enable, :cr11_des, :cr11_score, :cr11_enable, :cr12_des, :cr12_score, :cr12_enable, :cr13_des, :cr13_score, :cr13_enable, :cr14_des, :cr14_score, :cr14_enable, :cr15_des, :cr15_score, :cr15_enable, :cr16_des, :cr16_score, :cr16_enable)
    end
end
