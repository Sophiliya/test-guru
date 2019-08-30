class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_test
  # rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to test_path(@test)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to test_path(@test)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to test_path(@test)
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_test
    @test = params[:test_id] ? Test.find(params[:test_id]) : @question.test
  end

  def rescue_with_not_found
    render plain: "Ошибка 404: Вопрос не найден"
  end
end
