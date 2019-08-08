class AddConstraintToAnswers < ActiveRecord::Migration[5.2]
  def change
    change_column :answers, :body, :string, null: false
    change_column :answers, :question_id, :integer, null: false 
  end
end
