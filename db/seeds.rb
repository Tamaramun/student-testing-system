user = User.create(email: 'teacher@example.com', password: '12345678', password_confirmation: '12345678')
tests = []
5.times do
  tests << Test.create(name: Faker::Lorem.word, description: Faker::Lorem.sentence(3))
end

questions = []
2.times do
  tests.each do |test|
  questions << Question.create(question: Faker::Lorem.sentence(4) + '?', test_id: test.id)
  end
end

4.times do
  questions.each do |question|
    Answer.create(question_id: question.id, content: Faker::Lorem.sentence(4))
  end
end