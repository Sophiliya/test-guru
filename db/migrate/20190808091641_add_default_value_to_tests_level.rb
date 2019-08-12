class AddDefaultValueToTestsLevel < ActiveRecord::Migration[5.2]
  def up
    change_column :tests, :level, :integer, default: 1
  end

  def down
    change_column :tests, :level, :integer
  end
end
