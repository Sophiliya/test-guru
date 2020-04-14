class Badge < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :test, optional: true

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  before_save :set_image, on: :create

  private

  def set_image
    self.image = 'badge.png'
  end
end