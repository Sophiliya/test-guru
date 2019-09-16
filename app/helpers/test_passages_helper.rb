module TestPassagesHelper
  def show_score
    content_tag :h3, @test_passage.correct_questions, class: "result-#{result_type}"
  end

  def show_message
    content_tag :p, "Тест #{result_type == 'success' ? 'успешно пройден' : 'не пройден'}"
  end

  private

  def result_type
    @result >= 0.85 ? 'success' : 'fail'
  end
end
