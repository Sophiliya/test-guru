class Badge < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :test, optional: true

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  before_save :set_image, on: :create
  before_save :set_name, on: :create

  validates :name, uniqueness: { scope: :attempts_number }

  private

  def set_image
    self.image = 'badge.png'
  end

  def set_name
    self.name = "B#{test_id || 0}#{category_id || 0}#{level || 0}"
  end
end