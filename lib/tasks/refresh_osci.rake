# frozen_string_literal: true

task refresh_osci: :environment do
  JobMatrix.find_each(&:setup_jobs)
  Job.find_each(&:setup_builds)
  Build.find_each(&:setup_build_results)
end
