require 'digest/sha1'

class User < ApplicationRecord
  enum role: %i[admin regular]

  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id'
  has_many :test_passages
  has_many :tests, through: :test_passages

  has_secure_password

  def tests_by_level(level)
    self.tests.where(level: level)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
