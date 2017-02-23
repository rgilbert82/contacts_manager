class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :location
      t.text :description
      t.datetime :start_time, :end_time
      t.integer :user_id

      t.timestamps
    end
  end
end
