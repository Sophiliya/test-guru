class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users

  def tests_by_level(level)
    self.tests.where(level: level)
  end
end
