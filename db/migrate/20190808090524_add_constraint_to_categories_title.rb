class AddConstraintToCategoriesTitle < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :title, :string, null: false 
  end
end
