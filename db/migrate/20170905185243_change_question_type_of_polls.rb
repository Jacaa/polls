class ChangeQuestionTypeOfPolls < ActiveRecord::Migration[5.1]
  def change
    change_column :polls, :question, :string
  end
end
