class AddPendingToBuildResult < ActiveRecord::Migration[5.2]
  def change
    add_column :build_results, :pending, :boolean
  end
end
