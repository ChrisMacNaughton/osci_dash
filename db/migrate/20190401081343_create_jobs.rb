class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs, id: :uuid do |t|
      t.text :name
      t.references :job_matrix, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
