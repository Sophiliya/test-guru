class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :answers_count, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def answers_count
    errors.add(:answer, 'number is too much') if question.answers.count >= 4
  end
end
