class Admin::AnswersController < Admin::BaseController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question

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
      redirect_to admin_question_answers_path(@question)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to admin_question_answers_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to admin_question_answers_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = params[:question_id] ? Question.find(params[:question_id]) : @answer.question
  end
end
