class ResultsController < ApplicationController
  def index

  end

  def new
    @test = Test.find(params[:id])
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)
    @result.test_id = params[:id]
    if @result.save
      redirect_to pass_test_path(@result)
    else
      render 'new'
    end
  end

  def pass_test
    @answer_checking = AnswerChecking.new
    @result = Result.find(params[:id])
    @questions = Question.where(:test_id => @result.test_id)
  end

  def save_answer
      @answer = Answer.find(params[:answerId])
      @question = Question.find(params[:questionId])
      @result = Result.find(params[:id])
       @answers = AnswerChecking.where(:question_id => @question.id, :result_id => @result.id)
       if @answers[0]
         @answer_checking = @answers[0]
         @answer_checking.answer_id = @answer.id
         @answer_checking.save!
        else
          @answer_checking = AnswerChecking.new
          @answer_checking.question_id = @question.id
          @answer_checking.result_id = @result.id
          @answer_checking.answer_id = @answer.id
          @answer_checking.save!
        end

      render plain: params[:answer_checking].inspect
  end

  private
  def result_params
    params.require(:result).permit(:student_name, :student_group, :number_of_correct_answers, :student_last_name)
  end
end
