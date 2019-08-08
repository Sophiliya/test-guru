class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :body
      t.integer :test_id, foreign_key: true 
      t.timestamps
    end
  end
end
