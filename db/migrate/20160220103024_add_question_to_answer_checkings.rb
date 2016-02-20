class AddQuestionToAnswerCheckings < ActiveRecord::Migration
  def change
    add_reference :answer_checkings, :question, index: true, foreign_key: true
  end
end
