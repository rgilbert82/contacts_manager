class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.datetime :start_time, :end_time
      t.integer :user_id

      t.timestamps
    end
  end
end
