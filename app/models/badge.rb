class Badge < ApplicationRecord
  enum rule: { category_complete: 0, level_complete: 1, first_attempt: 2, second_attempt: 3 }

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  before_save :set_image, on: :create

  validates :name, uniqueness: true

  private

  def set_image
    self.image = 'badge.png'
  end
end