class AnswersController < ApplicationController
  before_action :authenticate_user!
  def index
    @answers = Answer.all
  end

  def new
    @answer = Answer.new
    @test = Test.find(params[:test_id])
    @question = Question.find(params[:question_id])
  end

  def create
    @test = Test.find(params[:test_id])
    @question = Question.find(params[:question_id])
    @answers = Answer.where(:question_id => @question.id)
    @answers.each do |answer|
      if answer.is_correct
        @answer = @question.answers.build(answer_params)
        @answer.is_correct = false
      else
        @answer = @question.answers.build(answer_params)
      end
    end


    if @answer.save
      redirect_to test_question_url(@test, @question)
    else
      render 'new'
    end
  end

  def edit
    @test = Test.find(params[:test_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    @test = Test.find(params[:test_id])
    @question = Question.find(params[:question_id])
    @answers = Answer.where(:question_id => @question.id)
    @answers.each do |answer|
      if answer.is_correct and @answer.is_correct
        @answer.is_correct = false
      else
        @answer.update(answer_params)
      end
    end
    if @answer.save
      redirect_to test_question_url(@test, @question)
    else
      render 'edit'
    end
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def destroy
    test = Test.find(params[:test_id])
    question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.destroy

    redirect_to test_question_path(test, question)
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :is_correct, :question_id)
  end
end
