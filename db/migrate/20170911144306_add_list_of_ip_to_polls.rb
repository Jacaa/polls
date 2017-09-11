class AddListOfIpToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :list_of_ip, :string, array: true, default: []
  end
end
