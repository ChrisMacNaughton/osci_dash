# frozen_string_literal: true

class BuildResultsController < ApplicationController
  before_action :set_build_result, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:show]

  def show
    @build_result = BuildResult.find(params[:id])
  end

  # GET /jobs/new
  def new
    @build_result = BuildResult.new(build_id: params[:build],
                                    ubuntu_release: params[:ubuntu],
                                    openstack_release: params[:openstack])
    @job_matrix = Build.find(params[:build]).job.job_matrix
  end

  def edit; end

  # POST /jobs
  # POST /jobs.json
  def create
    @build_result = BuildResult.new(build_result_params)
    @build_result.manual = true
    @build_result.ran_at = Time.now.in_time_zone
    @build_result.duration = 0.seconds
    @build_result.user = current_user
    respond_to do |format|
      if @build_result.save
        format.html { redirect_to @build_result.build.job.job_matrix, notice: 'Build was successfully created.' }
        format.json { render :show, status: :created, location: @build_result }
      else
        format.html { render :new }
        format.json { render json: @build_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /build_results/1
  # PATCH/PUT /build_results/1.json
  def update
    respond_to do |format|
      if @build_result.update(build_result_params)
        format.html { redirect_to @build_result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @build_result }
      else
        format.html { render :edit }
        format.json { render json: @build_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_results/1
  # DELETE /build_results/1.json
  def destroy
    matrix = @build_result.build.job.job_matrix
    @build_result.destroy
    respond_to do |format|
      format.html { redirect_to matrix, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_build_result
    @build_result = BuildResult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def build_result_params
    params.require(:build_result).permit(:build_id, :ubuntu_release, :openstack_release,
                                         :url, :passed, :note, :pending)
  end
end
