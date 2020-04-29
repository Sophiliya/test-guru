class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]
  before_action :set_current_question_number, only: :show

  def show
  end

  def result
    TestsMailer.completed_test(@test_passage).deliver_now
    @result = @test_passage.result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
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
end
