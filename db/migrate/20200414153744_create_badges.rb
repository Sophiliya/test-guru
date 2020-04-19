class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image
      t.integer :attempts_number
      t.integer :level

      t.string :rule_code
      t.integer :rule_priority

      t.references :category
      t.references :test

      t.timestamps
    end
  end
end
