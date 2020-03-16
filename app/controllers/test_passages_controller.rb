class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]
  before_action :set_current_question_number, only: :show

  def show
  end

  def result
    @result = @test_passage.result
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
    result = GistQuestionService.new(@test_passage.current_question).call
    gist = Gist.new(url: result[:html_url], question: @test_passage.current_question, user: current_user)

    flash_options = if gist.save
                      { notice: t('.success', url: gist.url) }
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
    @number = @test_passage.test.questions.order(:id).index(@test_passage.current_question)
  end
end
