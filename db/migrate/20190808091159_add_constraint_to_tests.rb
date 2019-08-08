class AddConstraintToTests < ActiveRecord::Migration[5.2]
  def change
    change_column :tests, :title, :string, null: false
    change_column :tests, :level, :integer, null: false 
  end
end
