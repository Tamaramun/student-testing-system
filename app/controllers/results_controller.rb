class ResultsController < ApplicationController
  def index
    @test = Test.find(params[:id])
    @results = Result.where(:test_id => @test.id)
    @questions_number = Question.where(:test_id => @test.id).length
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

      @result.number_of_correct_answers = count_correct_answers(@result)
      @result.save!

      render plain: params[:answer_checking].inspect
  end

  def destroy
    @result = Result.find(params[:id])
    test = Test.find(@result.test_id)
    @result.destroy

    redirect_to test_results_url(test)
  end

  def view_report
    @result = Result.find(params[:id])
    test = Test.find(@result.test_id)
    @questions = Question.where(:test_id => test.id)
    @questions_number = @questions.length
    @total_percentage = @result.number_of_correct_answers.to_i/@questions_number
    @answer_checking = AnswerChecking.where(:result_id => @result.id)[0]
  end


  private
  def result_params
    params.require(:result).permit(:student_name, :student_group, :number_of_correct_answers, :student_last_name)
  end

  def count_correct_answers(result)
    checkings = AnswerChecking.where(:result_id => result.id)
    number_of_correct_answers = 0
    checkings.each do |checking|
      answer = Answer.where(:question_id => checking.question_id, is_correct: true)[0]
      if answer and  checking.answer_id == answer.id
        number_of_correct_answers += 1
      else
        number_of_correct_answers = 0
      end
    end
  end
end
