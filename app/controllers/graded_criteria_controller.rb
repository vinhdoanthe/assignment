class GradedCriteriaController < ApplicationController
  before_action :require_admin!
  before_action :set_graded_criterium, only: [:show, :edit, :update, :destroy]

  # GET /graded_criteria
  # GET /graded_criteria.json
  def index
    @graded_criteria = GradedCriterium.all
  end

  # GET /graded_criteria/1
  # GET /graded_criteria/1.json
  def show
  end

  # GET /graded_criteria/new
  def new
    @graded_criterium = GradedCriterium.new
  end

  # GET /graded_criteria/1/edit
  def edit
  end

  # POST /graded_criteria
  # POST /graded_criteria.json
  def create
    @graded_criterium = GradedCriterium.new(graded_criterium_params)

    respond_to do |format|
      if @graded_criterium.save
        format.html { redirect_to @graded_criterium, notice: 'Graded criterium was successfully created.' }
        format.json { render :show, status: :created, location: @graded_criterium }
      else
        format.html { render :new }
        format.json { render json: @graded_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graded_criteria/1
  # PATCH/PUT /graded_criteria/1.json
  def update
    respond_to do |format|
      if @graded_criterium.update(graded_criterium_params)
        format.html { redirect_to @graded_criterium, notice: 'Graded criterium was successfully updated.' }
        format.json { render :show, status: :ok, location: @graded_criterium }
      else
        format.html { render :edit }
        format.json { render json: @graded_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graded_criteria/1
  # DELETE /graded_criteria/1.json
  def destroy
    @graded_criterium.destroy
    respond_to do |format|
      format.html { redirect_to graded_criteria_url, notice: 'Graded criterium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graded_criterium
      @graded_criterium = GradedCriterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graded_criterium_params
      params.require(:graded_criterium).permit(:graded_rubric_id, :description, :point, :required, :status, :comment)
    end
end
