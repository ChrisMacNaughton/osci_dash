# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id            :uuid             not null, primary key
#  name          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  job_matrix_id :uuid
#
# Indexes
#
#  index_jobs_on_job_matrix_id  (job_matrix_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_matrix_id => job_matrices.id)
#

require 'jenkins_api_client'

class Job < ApplicationRecord
  belongs_to :job_matrix
  has_many :builds, dependent: :destroy

  after_create_commit :setup_builds_async

  def latest_build
    builds.order(build_number: :desc).first
  end

  def setup_builds_async
    JobBuilderJob.perform_later id
  end

  def setup_builds
    uosci_config = Rails.application.config_for(:uosci).deep_symbolize_keys
    client = JenkinsApi::Client.new(server_ip: uosci_config[:path])
    client.job.get_builds(name).each do |build|
      Build.where(job: self, url: build['url'], build_number: build['number']).first_or_create
    end
    builds
  end

  def passing?
    builds.order(build_number: :desc).limit(1).pluck(:passed)[0]
  end
end
