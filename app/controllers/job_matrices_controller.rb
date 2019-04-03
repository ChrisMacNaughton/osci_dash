# frozen_string_literal: true

class JobMatricesController < ApplicationController
  before_action :set_job_matrix, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]

  # GET /job_matrices
  # GET /job_matrices.json
  def index
    @job_matrices = JobMatrix.all
  end

  # GET /job_matrices/1
  # GET /job_matrices/1.json
  def show
    @builds = @job_matrix.latest_builds.group_by(&:job_id)
    @build_results = BuildResult
                     .where(build_id: @job_matrix.latest_builds.pluck(:id))
                     .order(created_at: :desc).includes(:user).group_by(&:build_id)
  end

  # GET /job_matrices/new
  def new
    @job_matrix = JobMatrix.new
  end

  # GET /job_matrices/1/edit
  def edit; end

  # POST /job_matrices
  # POST /job_matrices.json
  def create
    @job_matrix = JobMatrix.new(job_matrix_params)

    respond_to do |format|
      if @job_matrix.save
        format.html { redirect_to @job_matrix, notice: 'Job matrix was successfully created.' }
        format.json { render :show, status: :created, location: @job_matrix }
      else
        format.html { render :new }
        format.json { render json: @job_matrix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_matrices/1
  # PATCH/PUT /job_matrices/1.json
  def update
    respond_to do |format|
      if @job_matrix.update(job_matrix_params)
        format.html { redirect_to @job_matrix, notice: 'Job matrix was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_matrix }
      else
        format.html { render :edit }
        format.json { render json: @job_matrix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_matrices/1
  # DELETE /job_matrices/1.json
  def destroy
    @job_matrix.destroy
    respond_to do |format|
      format.html { redirect_to job_matrices_url, notice: 'Job matrix was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job_matrix
    @job_matrix = JobMatrix.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_matrix_params
    params.require(:job_matrix).permit(:name, :filter, :rename_filter)
  end
end
