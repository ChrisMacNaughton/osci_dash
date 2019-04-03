# frozen_string_literal: true

# == Schema Information
#
# Table name: job_matrices
#
#  id            :uuid             not null, primary key
#  filter        :text
#  name          :text
#  rename_filter :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'jenkins_api_client'

class JobMatrix < ApplicationRecord
  has_many :jobs, dependent: :destroy

  after_create_commit :setup_jobs_async

  def passing?
    @passing ||= Build
                 .where(job_id: Job.where(job_matrix: self))
                 .group(:job_id, :passed).pluck(:passed).all?
  end

  def setup_jobs_async
    MatrixBuilderJob.perform_later id
  end

  def latest_builds
    @latest_builds ||= Build
                       .where(job: Job.where(job_matrix: self))
                       .select('DISTINCT ON ("builds"."job_id") job_id, "builds".*')
                       .order(:job_id, build_number: :desc)
  end

  def setup_jobs
    uosci_config = Rails.application.config_for(:uosci).deep_symbolize_keys
    client = JenkinsApi::Client.new(server_ip: uosci_config[:path])
    client.view.list_jobs(name).each do |job|
      if filter
        Job.where(job_matrix: self, name: job).first_or_create \
          if job.match?(filter)
      else
        Job.where(job_matrix: self, name: job).first_or_create
      end
    end
  end
end
