class AddDefaultValueToAnswersCorrect < ActiveRecord::Migration[5.2]
  def up
    change_column :answers, :correct, :boolean, default: false
  end

  def down
    change_column :answers, :correct, :boolean 
  end
end
