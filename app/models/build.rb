# frozen_string_literal: true

# == Schema Information
#
# Table name: builds
#
#  id           :uuid             not null, primary key
#  build_number :integer
#  display_name :text
#  duration     :interval
#  passed       :boolean
#  url          :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  job_id       :uuid
#
# Indexes
#
#  index_builds_on_job_id  (job_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_id => jobs.id)
#

require 'jenkins_api_client'

class Build < ApplicationRecord
  belongs_to :job
  has_many :build_results, dependent: :destroy

  after_create_commit :setup_build_results_async

  def setup_build_results_async
    BuildBuilderJob.perform_later id
  end

  def setup_build_results
    uosci_config = Rails.application.config_for(:uosci).deep_symbolize_keys
    client = JenkinsApi::Client.new(server_ip: uosci_config[:path])
    details = client.job.get_build_details(job.name, build_number)
    self.duration = "#{details['duration']} milliseconds"
    self.passed = details['result'] == 'SUCCESS'
    details['runs']&.each do |run|
      run_details = client.api_get_request(run['url'])
      ran_at = Time.at(run_details['timestamp'] / 1000.0).utc.to_datetime
      BuildResult.unscoped.where(build: self, url: run['url']).first_or_create! do |result|
        result.duration = "#{run_details['duration']} milliseconds"
        result.passed = run_details['result'] == 'SUCCESS'
        result.url = run_details['url']
        uos = run_details['url'].split('/')[-2].split(',')[-1].sub('U_OS=', '')
        result.ubuntu_release, result.openstack_release = uos.split('-')
        result.ran_at = ran_at
      end
    end
    save
    build_results
  end
end
