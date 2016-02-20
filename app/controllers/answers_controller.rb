class AnswersController < ApplicationController

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
    @answer = @question.answers.build(answer_params)
    # if @answer.is_correct
    #   @answers = Answer.where(:qusetion_id => @question.id)
    #   @answers.each do |answer|
    #     unless answer.is_correct
    #       true
    #     end
    #   end
    # end
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

    if @answer.update(answer_params)
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
