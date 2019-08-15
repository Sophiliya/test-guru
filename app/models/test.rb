class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  has_many :tests_users
  has_many :users, through: :tests_users

  def self.by_category(category_title)
    Test.includes(:category).where(
      categories: { title: category_title }
    ).order(title: :desc).map(&:title)
  end
end
