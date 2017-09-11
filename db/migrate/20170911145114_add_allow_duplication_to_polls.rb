class AddAllowDuplicationToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :allow_duplication, :boolean, default: false
  end
end
