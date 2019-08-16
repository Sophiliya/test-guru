class DropAnswersTestsUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :answers_tests_users
  end
end
