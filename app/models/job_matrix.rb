# frozen_string_literal: true

# == Schema Information
#
# Table name: job_matrices
#
#  id         :uuid             not null, primary key
#  filter     :text
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'jenkins_api_client'

class JobMatrix < ApplicationRecord
  has_many :jobs, dependent: :destroy

  after_create_commit :setup_jobs_async

  def setup_jobs_async
    MatrixBuilderJob.perform_later id
  end

  def setup_jobs
    uosci_config = Rails.application.config_for(:uosci).deep_symbolize_keys
    client = JenkinsApi::Client.new(server_ip: uosci_config[:path])
    client.view.list_jobs(name).each do |job|
      if filter
        Job.where(job_matrix: self, name: job).first_or_create \
          unless filter.nil?
      else
        Job.where(job_matrix: self, name: job).first_or_create
      end
    end
  end
end
