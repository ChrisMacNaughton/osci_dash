# frozen_string_literal: true

module JobMatricesHelper
  def job_table_status(job)
    if job.builds?
      job.passing? ? 'table-success' : 'table-danger'
    else
      'table-info'
    end
  end
end
