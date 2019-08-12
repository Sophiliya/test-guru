class AddConstraintToCategoriesTitle < ActiveRecord::Migration[5.2]
  def up
    change_column :categories, :title, :string, null: false
  end

  def down
    change_column :categories, :title, :string 
  end
end
