class CreateBuildResults < ActiveRecord::Migration[5.2]
  def change
    create_table :build_results, id: :uuid do |t|
      t.boolean :manual, default: false
      t.boolean :passed
      t.text :url
      t.text :ubuntu_release
      t.text :openstack_release
      t.interval :duration
      t.datetime :ran_at
      t.references :build, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid, default: nil

      t.timestamps
    end
  end
end
