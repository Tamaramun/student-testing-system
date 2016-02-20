class AddAnswerToAnswerCheckings < ActiveRecord::Migration
  def change
    add_reference :answer_checkings, :answer, index: true, foreign_key: true
  end
end
