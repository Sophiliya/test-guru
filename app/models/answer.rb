class Answer < ApplicationRecord
  belongs_to :question
  has_and_belongs_to_many :tests_users
end
