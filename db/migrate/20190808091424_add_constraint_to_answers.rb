class AddConstraintToAnswers < ActiveRecord::Migration[5.2]
  def up
    change_column :answers, :body, :string, null: false
    change_column :answers, :question_id, :integer, null: false
  end

  def down
    change_column :answers, :body, :string
    change_column :answers, :question_id, :integer 
  end
end
