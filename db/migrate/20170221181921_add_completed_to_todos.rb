class AddCompletedToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :completed, :boolean, default: false
  end
end
