class AddNoteToBuildResult < ActiveRecord::Migration[5.2]
  def change
    add_column :build_results, :note, :text
  end
end
