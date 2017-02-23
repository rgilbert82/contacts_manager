class DropEndTimeFromTodos < ActiveRecord::Migration
  def change
    remove_column :todos, :end_time
  end
end
