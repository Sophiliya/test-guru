class QuestionsController < ApplicationController
  before_action :set_test
  before_action :set_question, only: %i[show destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def index
    @questions = @test.questions
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      render plain: "Вопрос ##{@question.id} создан."
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    render plain: "Вопрос ##{@question.id} удален."
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
    render plain: "Ошибка 404: Вопрос не найден"
  end
end
