class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable


  enum role: %i[admin regular]

  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id'
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :gists, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  def tests_by_level(level)
    self.tests.where(level: level)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    self.is_a?(Admin)
  end
end
