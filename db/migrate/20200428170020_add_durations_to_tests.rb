class AddDurationsToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :duration, :integer
  end
end
