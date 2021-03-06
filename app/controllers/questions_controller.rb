class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.all
  end

    def new
      @question = Question.new
    end

    def create
      @test = Test.find(params[:test_id])
      @question = @test.questions.build(question_params)

      if @question.save
        redirect_to test_url(@test)
      else
        render 'new'
      end
    end

    def edit
      @question = Question.find(params[:id])
    end

    def update
      @question = Question.find(params[:id])
      @test = Test.find(params[:test_id])

      if @question.update(question_params)
        redirect_to test_url(@test)
      else
        render 'edit'
      end
    end

    def show
      @question = Question.find(params[:id])
      @test = Test.find(params[:test_id])
      @answers = Answer.where(:question_id => @question.id)
    end

    def destroy
      @test = Test.find(params[:test_id])
      @question = Question.find(params[:id])
      @question.destroy

      redirect_to test_url(@test)
    end

    private
    def question_params
      params.require(:question).permit(:question, :test_id)
    end

end
