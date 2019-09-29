class TestsController < ApplicationController
  before_action :set_test, only: %i[show edit update start]

  def index
    @tests = Test.all
  end

  def show
  end

  def new
    @test = Question.new
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to tests_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @test = @test.update(test_params)

    if @test.save
      redirect_to tests_path
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    current_user.tests.push(@test)
    redirect_to test_passage_path(current_user.test_passage(@test))
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end
end
