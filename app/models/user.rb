class User < ApplicationRecord
  enum role: %i[admin regular]

  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id'
  has_many :tests_users
  has_many :tests, through: :tests_users

  validates :first_name, :last_name, :email, presence: true

  # scope :by_level, -> (level) { |level|
  #   where(level: level)
  # }

  def full_name
    "#{first_name} #{last_name}"
  end
end
