# frozen_string_literal: true

json.extract! job_matrix, :id, :name, :created_at, :updated_at
json.url job_matrix_url(job_matrix, format: :json)
