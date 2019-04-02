# frozen_string_literal: true

class MatrixBuilderJob < ApplicationJob
  queue_as :default

  def perform(matrix_id)
    # Do something later
    matrix = JobMatrix.find_by(id: matrix_id)
    matrix.setup_jobs
  end
end
