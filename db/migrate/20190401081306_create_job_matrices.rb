class CreateJobMatrices < ActiveRecord::Migration[5.2]
  def change
    create_table :job_matrices, id: :uuid do |t|
      t.text :name
      t.text :filter

      t.timestamps
    end
  end
end
