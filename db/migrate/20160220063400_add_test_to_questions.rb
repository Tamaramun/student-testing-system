class AddTestToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :test, index: true, foreign_key: true
  end
end
