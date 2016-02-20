class AnswerChecking < ActiveRecord::Base
  belongs_to :questions
  belongs_to :answers
end
