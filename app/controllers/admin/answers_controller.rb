class Admin::AnswersController < Admin::BaseController
  before_action :set_question
  before_action :set_answer, only: %i[show edit update destroy]

  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to admin_test_path(@test)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to admin_test_path(@question.test)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to admin_test_path(@question.test)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
