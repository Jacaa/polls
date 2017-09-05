class AddAnswersToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :answers, :string, array: true, default: []
    remove_column :polls, :answer
  end
end
