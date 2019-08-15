class User < ApplicationRecord
  enum role: %i[admin regular]

  has_many :tests
  has_many :tests_users
  has_many :tests, through: :tests_users

  def tests_by_level(level)
    self.tests.where(level: level)
  end
end
