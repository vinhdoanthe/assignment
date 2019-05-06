class CriteriaFormatsController < ApplicationController
  before_action :require_admin!
  before_action :set_criteria_format, only: [:show, :edit, :update, :destroy]

  # GET /criteria_formats
  # GET /criteria_formats.json
  def index
    @criteria_formats = CriteriaFormat.all
  end

  # GET /criteria_formats/1
  # GET /criteria_formats/1.json
  def show
  end

  # GET /criteria_formats/new
  def new
    @criteria_format = CriteriaFormat.new
  end

  # GET /criteria_formats/1/edit
  def edit
  end

  # POST /criteria_formats
  # POST /criteria_formats.json
  def create
    @criteria_format = CriteriaFormat.new(criteria_format_params)

    respond_to do |format|
      if @criteria_format.save
        format.html { redirect_to @criteria_format, notice: 'Criteria format was successfully created.' }
        format.json { render :show, status: :created, location: @criteria_format }
      else
        format.html { render :new }
        format.json { render json: @criteria_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criteria_formats/1
  # PATCH/PUT /criteria_formats/1.json
  def update
    respond_to do |format|
      if @criteria_format.update(criteria_format_params)
        format.html { redirect_to @criteria_format, notice: 'Criteria format was successfully updated.' }
        format.json { render :show, status: :ok, location: @criteria_format }
      else
        format.html { render :edit }
        format.json { render json: @criteria_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criteria_formats/1
  # DELETE /criteria_formats/1.json
  def destroy
    @criteria_format.destroy
    respond_to do |format|
      format.html { redirect_to criteria_formats_url, notice: 'Criteria format was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criteria_format
      @criteria_format = CriteriaFormat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criteria_format_params
      params.require(:criteria_format).permit(:rubric_id, :description, :point, :required)
    end
end
