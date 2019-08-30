class User < ApplicationRecord
  enum role: %i[admin regular]

  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id'
  has_many :tests_users
  has_many :tests, through: :tests_users

  validates :first_name, :last_name, :email, presence: true

  def tests_by_level(level)
    self.tests.where(level: level)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
