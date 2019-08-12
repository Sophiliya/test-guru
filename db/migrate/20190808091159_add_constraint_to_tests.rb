class AddConstraintToTests < ActiveRecord::Migration[5.2]
  def up
    change_column :tests, :title, :string, null: false
    change_column :tests, :level, :integer, null: false
  end

  def down
    change_column :tests, :title, :string
    change_column :tests, :level, :integer 
  end
end
