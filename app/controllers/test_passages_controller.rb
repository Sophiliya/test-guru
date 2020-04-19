class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]
  before_action :set_current_question_number, only: :show
  before_action :set_result, :set_badge, :assign_badge, only: :result

  def show
  end

  def result

  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now 
      redirect_to result_test_passage_path(@test_passage)
    else
      redirect_to test_passage_path(@test_passage)
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    result = service.call

    flash_options = if service.success?
                      create_gist(result[:html_url])
                      { notice: t('.success', url: result[:html_url]) }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def set_current_question_number
    @number = @test_passage.test.questions.order(:id).index(@test_passage.current_question) + 1
  end

  def create_gist(url)
    current_user.gists.create(url: url, question: @test_passage.current_question)
  end

  def set_result
    @result = @test_passage.result
  end

  def set_badge
    return unless @result >= 0.85

    @badge = find_badge
  end

  def assign_badge
    return unless @badge

    user_badge = UserBadge.find_by(user: current_user, badge: @badge)

    if user_badge
      user_badge.update(count: user_badge.count + 1)
    else
      UserBadge.create(user: current_user, badge: @badge)
    end
  end

  def find_badge
    Badge.find_by_rules(
      test_id: @test_passage.test_id,
      category_id: @test_passage.test.category_id,
      level: @test_passage.test.level,
      attempts_number: attempts_number
    )
  end

  def attempts_number
    TestPassage.where(user: current_user, test: @test_passage.test).count
  end
end
