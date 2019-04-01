# frozen_string_literal: true

task refresh_osci: :environment do
  JobMatrix.find_each(&:setup_jobs_async)
  Job.find_each(&:setup_builds_async)
  Build.find_each(&:setup_build_results_async)
end
