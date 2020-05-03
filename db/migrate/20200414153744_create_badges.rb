class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image
      t.integer :rule, default: 0

      t.timestamps
    end
  end
end
