# frozen_string_literal: true

json.array! @job_matrices, partial: 'job_matrices/job_matrix', as: :job_matrix
