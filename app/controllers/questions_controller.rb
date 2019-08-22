class QuestionsController < ApplicationController
  before_action :set_test
  before_action :set_question, only: %i[show destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def index
    @questions = @test.questions
  end

  def show
    redirect_to test_question_path(@question)
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.create(question_params)
    render plain: "Вопрос ##{@question.id} создан."
  end

  def destroy
    @question.destroy
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def rescue_with_not_found
    render plain: "Вопрос не найден"
  end
end
