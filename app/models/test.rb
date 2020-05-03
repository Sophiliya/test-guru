class Test < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category

  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :title, presence: true
  validates :level, numericality: { only_integer: true }
  validates :level, uniqueness: { scope: :title }

  scope :simple, -> { where('level IN (?)', [0, 1]) }
  scope :middle, -> { where('level IN (?)', (2..4)) }
  scope :complicated, -> { where('level >= ?', 5) }
  scope :by_category, -> (category_title) { includes(:category).where(categories: { title: category_title }) }

  def self.by_category(category_title)
    Test.includes(:category).where(
      categories: { title: category_title }
    ).order(title: :desc).map(&:title)
  end
end
