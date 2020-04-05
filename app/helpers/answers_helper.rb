module AnswersHelper
  def answer_header(answer)
    if answer.new_record?
      "Новый ответ на вопрос: #{answer.question.body}"
    else
      "Редактировать ответ на вопрос: #{answer.question.body}"
    end
  end
end
