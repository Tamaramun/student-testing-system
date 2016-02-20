class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :student_name
      t.string :student_last_name
      t.string :student_group
      t.decimal :number_of_correct_answers

      t.timestamps null: false
    end
  end
end
