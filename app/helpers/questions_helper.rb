module QuestionsHelper
  def question_header(question)
    if question.new_record?
      "Новый вопрос по #{question.test.title}"
    else
      "Редактировать вопрос по #{question.test.title}"
    end
  end
end
