# frozen_string_literal: true

class BuildResultsController < ApplicationController
  before_action :authenticate_user!

  # GET /jobs/new
  def new
    @build_result = BuildResult.new(build_id: params[:build],
                                    ubuntu_release: params[:ubuntu],
                                    openstack_release: params[:openstack])
    @job_matrix = Build.find(params[:build]).job.job_matrix
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @build_result = BuildResult.new(job_matrix_params)
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_matrix_params
    params.require(:build_result).permit(:build_id, :ubuntu_release, :openstack_release, :url, :passed)
  end
end
