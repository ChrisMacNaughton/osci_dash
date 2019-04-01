class CreateBuilds< ActiveRecord::Migration[5.2]
  def change
    create_table :builds, id: :uuid do |t|
      t.text :display_name
      t.integer :build_number
      t.text :url
      t.interval :duration
      t.boolean :passed
      t.references :job, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
