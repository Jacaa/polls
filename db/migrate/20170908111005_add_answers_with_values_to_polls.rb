class AddAnswersWithValuesToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :answers_with_values, :JSON
  end
end
