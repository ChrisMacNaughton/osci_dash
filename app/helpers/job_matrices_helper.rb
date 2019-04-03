# frozen_string_literal: true

module JobMatricesHelper
  def job_table_status(job)
    if job.builds?
      passing_table_status job.passing?
    else
      'table-info'
    end
  end
end
