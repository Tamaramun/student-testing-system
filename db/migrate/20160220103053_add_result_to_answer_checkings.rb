class AddResultToAnswerCheckings < ActiveRecord::Migration
  def change
    add_reference :answer_checkings, :result, index: true, foreign_key: true
  end
end
