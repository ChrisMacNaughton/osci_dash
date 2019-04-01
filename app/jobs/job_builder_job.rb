# frozen_string_literal: true

class JobBuilderJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    job = Job.find_by(id: id)
    job&.setup_builds
  end
end
