class AddConstraintToQuestionsBody < ActiveRecord::Migration[5.2]
  def up
    change_column :questions, :body, :text, null: false
  end

  def down
    change_column :questions, :body, :text 
  end
end
