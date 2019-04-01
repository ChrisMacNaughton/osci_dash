# frozen_string_literal: true

class BuildBuilderJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    build = Build.find_by(id: id)
    build&.setup_build_results
  end
end
