module TestPassagesHelper
  def show_score
    content_tag :h3, @test_passage.correct_questions, class: "result-#{result_type}"
  end

  def show_message
    content_tag :p, "#{result_type == 'success' ? t('test_passages.result.success') : t('test_passages.result.fail')}"
  end

  def show_badge
    if @badge
      image_tag @badge.image, class: 'badge-img'
    end
  end

  private

  def result_type
    @result >= 0.85 ? 'success' : 'fail'
  end
end
