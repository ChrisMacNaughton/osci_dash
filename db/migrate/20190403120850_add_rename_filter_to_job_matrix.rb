class AddRenameFilterToJobMatrix < ActiveRecord::Migration[5.2]
  def change
    add_column :job_matrices, :rename_filter, :text
  end
end
