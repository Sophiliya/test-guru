class Badge < ApplicationRecord
  enum rule: { backend: 0, frontend: 1, level_1: 2, level_2: 3, attempt_1: 4, attempt_2: 5 }

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  before_save :set_image, on: :create

  validates :name, uniqueness: true

  private

  def set_image
    self.image = 'badge.png'
  end
end