class AddAllowMultipleToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :allow_multiple, :boolean, default: false
  end
end
