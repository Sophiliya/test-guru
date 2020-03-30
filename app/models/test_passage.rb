class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, if: :new_record?
  before_save :before_save_set_next_question, unless: :new_record?

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save
  end

  def completed?
    current_question.nil? ? true : false
  end

  def result
    correct_questions.to_f/test.questions.count
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.order(:id).first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def before_save_set_next_question
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
