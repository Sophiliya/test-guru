module QuestionsHelper
  def question_header(question, test)
    if question.new_record?
      "Новый вопрос по #{test.title}"
    else
      "Редактировать вопрос по #{test.title}"
    end
  end
end
