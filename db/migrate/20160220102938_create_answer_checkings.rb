class CreateAnswerCheckings < ActiveRecord::Migration
  def change
    create_table :answer_checkings do |t|

      t.timestamps null: false
    end
  end
end
