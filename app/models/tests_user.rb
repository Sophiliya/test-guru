class TestsUser < ApplicationRecord
  belongs_to :test
  belongs_to :user

  has_and_belongs_to_many :answers 
end
