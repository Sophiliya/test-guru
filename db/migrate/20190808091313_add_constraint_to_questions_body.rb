class AddConstraintToQuestionsBody < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :body, :text, null: false 
  end
end
