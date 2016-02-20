class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.boolean :is_correct

      t.timestamps null: false
    end
  end
end